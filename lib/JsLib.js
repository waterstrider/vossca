.pragma library

function shallowCopy(obj) {
    var clone = {};
    for(var i in obj) {
        clone[i] = obj[i];
    }
    return clone;
}
