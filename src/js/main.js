// Import our custom CSS
import '../scss/styles.scss'

// // Import all of Bootstrap's JS
// import * as bootstrap from 'bootstrap'


// import Alert from 'bootstrap/js/dist/alert'


// // or, specify which plugins you need:
// import { Tooltip, Toast, Popover } from 'bootstrap'
const InfoMessageType = {
  ERR: 1,
  WARN: 2,
  INFO: Symbol("green")
};
Object.freeze(InfoMessageType);

let balanceData = [];

let restURL = 'http://localhost:8089/services/rest.api.php';
let monthsOfYear = {0:'Jan',0:'Feb',2:'Mar',3:'Apr',4:'May',5:'Jun',6:'Jul',7:'Aug',8:'Sept',9:'Oct',10:'Nov',11:'Dec',};


let infoBoxUpdate = (infoMsg, infoMsgType) =>{
  let classList = document.querySelector("#info-box").classList
  classList.remove(...classList);
  classList.add("alert");
  document.querySelector("#info-box").innerHTML = infoMsg;
  if (infoMsgType === InfoMessageType.ERR){
    classList.add("alert-danger");
  } else if (infoMsgType === InfoMessageType.WARN){
    classList.add("alert-warning");
  } else if (infoMsgType === InfoMessageType.INFO){
    classList.add("alert-primary");
  }
}

let getallbalances = () => {
  fetch(`${restURL}/getallbalances/`, {
    method: "GET"
}).then(response => response.json())
.then(data => {
  let balanceListGroup = document.querySelector("#balance-list-group");
  balanceListGroup.innerHTML = null;
  data.forEach(balanceObject => {
    balanceData[balanceObject.id] = {value:balanceObject.value, datetime:new Date(balanceObject.balancetime_ts.replace(" ","T"))}
    let listGroupItem = document.createElement('li');
    listGroupItem.classList.add("list-group-item")
    listGroupItem.appendChild(
      Object.assign(
        document.createElement("input"),
        {
          class: "form-check-input me-1",
          type: "checkbox",
          name:'list-group-item',
          id:balanceObject.id
        }
      )
    );
    let innerHTMLText = `&#8377;${balanceData[balanceObject.id].value}; `;
    innerHTMLText += `${balanceData[balanceObject.id].datetime.getDate()} `;
    innerHTMLText += `${monthsOfYear[balanceData[balanceObject.id].datetime.getMonth()]}, `;
    innerHTMLText += `${balanceData[balanceObject.id].datetime.getFullYear()}, `;
    if (balanceData[balanceObject.id].datetime.getHours() == 12){
      innerHTMLText += `${balanceData[balanceObject.id].datetime.getHours()}:`;
      innerHTMLText += `${balanceData[balanceObject.id].datetime.getMinutes()} PM`;
    } else if (balanceData[balanceObject.id].datetime.getHours() < 12){
      innerHTMLText += `${balanceData[balanceObject.id].datetime.getHours()}:`;
      innerHTMLText += `${balanceData[balanceObject.id].datetime.getMinutes()} AM`;
    } else {
      innerHTMLText += `${balanceData[balanceObject.id].datetime.getHours()-12}:`;
      innerHTMLText += `${balanceData[balanceObject.id].datetime.getMinutes()} PM`;
    }
    
    listGroupItem.appendChild(
      Object.assign(
        document.createElement("label"),
        {
          class: "form-check-label",
          innerHTML:innerHTMLText,
          style:"margin-left:5px"
        }
      )
    );

    balanceListGroup.appendChild(listGroupItem);

  });
})
.catch((err) => {
  console.log(err);
})
}

window.onload = () => {
  if(window.location.href.includes("localhost")){
    restURL = 'http://localhost:8089/services/rest.api.php'
  } else {
    restURL = 'https://meter.peterb.in/services/rest.api.php/'
  }
  getallbalances();
};

document.querySelector("#save").addEventListener("click", (e) => {
  if (document.querySelector("#meter-balance").value && parseInt(document.querySelector("#meter-balance").value) >= 0){
    fetch(`${restURL}/savebalance/`, {
      method: "POST",
      body: JSON.stringify({
        balance: {
          value: document.querySelector("#meter-balance").value
        }
     })})
    .then(response => response.json())
    .then(data => {
      infoBoxUpdate(`New balance entry <b>${data.value}</b>`,InfoMessageType.INFO);
      getallbalances();
    })
    .catch((err) => {
      console.log(err);
    })} else {
      infoBoxUpdate("Enter some balance greater than zero",InfoMessageType.ERR);
    }
  
});

let getLastDate = (date, days) => {
  let result = new Date(); // not instatiated with date!!! DANGER
  result.setDate(date.getDate() + days);
  // return result.getDate();
  return `${result.getDate()} ${monthsOfYear[result.getMonth()]}, ${result.getFullYear()}`;
}
document.querySelector('#rate-info').addEventListener("click", (e) => {
  if (document.querySelectorAll("[name='list-group-item']:checked").length == 2){
    // let date2 = document.querySelectorAll("[name='list-group-item']:checked")[1].datetime;
    let date1 = balanceData[document.querySelectorAll("[name='list-group-item']:checked")[0].id].datetime;
    let date2 = balanceData[document.querySelectorAll("[name='list-group-item']:checked")[1].id].datetime;
    let balance1 = balanceData[document.querySelectorAll("[name='list-group-item']:checked")[0].id].value;
    let balance2 = balanceData[document.querySelectorAll("[name='list-group-item']:checked")[1].id].value;
    let ratepermillisecond = Math.abs(balance1 - balance2)/Math.abs((date1 - date2));
    let rateperday = ratepermillisecond*1000*3600*24;
    let ratepermonth = rateperday*(365.25/12);
    let daystolast = -1;
    let lastdate = null;
    if (balance1 < balance2){
      daystolast = Math.round(balance1/rateperday);
      lastdate = getLastDate((new Date(date1)),daystolast);
    } else if (balance1 > balance2){
      daystolast = Math.round(balance2/rateperday);
      lastdate = getLastDate((new Date(date2)),daystolast);
    }
    let innerHTMLString = '<table class="table table-bordered"><tr><th>Daily</th><th>Monthly</th><th>Days to go</th></tr>';
    innerHTMLString += '<tr>';
    innerHTMLString += `<td>&#8377;${Math.round(rateperday)}</td>`;
    innerHTMLString += `<td>&#8377;${Math.round(ratepermonth)}</td>`;
    innerHTMLString += `<td>${Math.round(daystolast)} <span class="badge text-bg-success">${lastdate}</span></td>`;
    innerHTMLString += '</tr></table>';
    infoBoxUpdate(innerHTMLString, InfoMessageType.INFO)
  } else {
    infoBoxUpdate("You need to select <b>ONLY</b> two dates", InfoMessageType.ERR)
  }

})
document.querySelectorAll('[time-period]').forEach(button => 
  button.addEventListener('click', () => {
    if (document.querySelectorAll("[name='list-group-item']:checked").length == 2){
      // let date2 = document.querySelectorAll("[name='list-group-item']:checked")[1].datetime;
      let date1 = balanceData[document.querySelectorAll("[name='list-group-item']:checked")[0].id].datetime;
      let date2 = balanceData[document.querySelectorAll("[name='list-group-item']:checked")[1].id].datetime;
      let balance1 = balanceData[document.querySelectorAll("[name='list-group-item']:checked")[0].id].value;
      let balance2 = balanceData[document.querySelectorAll("[name='list-group-item']:checked")[1].id].value;
      let ratepermillisecond = Math.abs(balance1 - balance2)/Math.abs((date1 - date2));
      let outputrate = ratepermillisecond*1000*3600*24;
      if (button.attributes['time-period'].value == "month"){
        outputrate = outputrate*(365.25/12);
      }
      infoBoxUpdate(`Rate per day: &#8377;${Math.round(outputrate)}`, InfoMessageType.INFO)
    } else {
      infoBoxUpdate("You need to select <b>ONLY</b> two dates", InfoMessageType.ERR)
    }
      
  })
);
