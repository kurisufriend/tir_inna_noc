archive for the clover website
not named after a character from yotsuba& (sorry)
yotsuba is very cute though

hash post/<board>/<id> ->
    string postjson
    string sage //y/n

hash thread/<board>/<id> ->
    string last_update
    string on_page
    string reply_number
    string posts //<id>,<id>,<id>,...

string img <board>/<tim>/<ext> // binary

set boards -> // all archived boards
    string <board>
