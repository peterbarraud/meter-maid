# The meter maid

(Preferably run the steps 1 to 3 in `Git bash`)
1. Clone this repo
1. cd into the resultant folder
1. Run the following commands to get the Dr. Nefario servers
```
git clone https://github.com/peterbarraud/the.dr.nefario.servers.git
mv the.dr.nefario.servers/mariadb.min/ backoffice/
mv the.dr.nefario.servers/php.min/ backoffice/
rm -fr the.dr.nefario.servers/
```
4. Start mariadb with: `db.start.bat`
1. Sign into mariadb with: `login.root.bat`
1. Use `backoffice/services/db.sql` to create the basic meter database structure.

    At any point, to export the databse simple run `export.db.bat` with the database name as the only arg. The <database name>.sql file is created in `backoffice/services` dir

1. Start the php server using: `php.start.bat`
1. Install the npm dependencies using `npm i`
1. Start your website with `npm start`

## Backoffice
### Object layer
We have this PHP-based object layer to keep things as simple as possible. It's not very complicated, but seems to work pretty well.

(**Note** We still haven't accounted for many-to-many relations)
#### Creating an object
So, let's say you have an entity like user (let's call this `app user`). What you do is:

1. Create an appuser table which must have the primary key as an integer type field. (And, of course, other fields, besides)
1. You then create the following php objects:
    1. `appuser` (see the example in this repo)
    2. `appusercollection`

**Note**: We have one interesting field - a `timestamp` field. If you have a timestamp field, we recommend that you us the `_ts` suffix for the field time. We will then update that field for any update to a table entry. If you make a new entry, you should not set the timestamp field - we will make the timestamp entry. If you update the entry, we will update the timestamp entry.

Notes for objects:
1. The **object** class constructor takes a single (optional) parameter.
    1. ID will return the complete object (as per the corresponding database entity). Update any property and hit save (`{object}->Save();`) and you have an updated database entry
    2. Pass nothing and you get an empty object. What do I do with an empty object, you may ask? Well, PHP kindly allows you to assign properties to an object (just like that). Assign the fields some values (maybe for a new entry), hit save (`{object}->Save();`) and voila, you have a new database entry
2. The **object collection** class returns a collection of  object.
    1. The collection class takes lots of parameters (all optional). If you don't give any params, you'll get back a collection of all the database entries for that object.
    1. Parameters:
        
        * **$filter**: Pass one Namevalue object, or an array of NameValue objects (for multiple filters)
        
        * **sortby**: field to sort by. Currently, we only support a single field
        
        * **$sortdirection**: Sort direction - `asc` or `desc`

        * **$limit**: A number of entries to get
    1. Methods:
        * **getobjectcollection()**: gets the object collection
        * **length()**: gets the length of the collection

