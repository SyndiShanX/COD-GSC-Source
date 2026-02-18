/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: core_common\class_shared.gsc
***********************************************/

#namespace class_shared;
class class_d0a0a887 {
  var _avail;
  var _used;

  constructor() {
    _avail = [];
    _used = [];
  }

  function function_271aec18(index) {
    assert(isDefined(_used[index]));
    _used[index] = undefined;
    assert(!isDefined(_avail[index]));
    _avail[index] = index;
  }

  function function_65cdd2df(owner) {
    index = undefined;

    foreach(key, value in _avail) {
      index = key;
      break;
    }

    if(isDefined(index)) {
      assert(!isDefined(_used[index]));

      if(isDefined(owner)) {
        _used[index] = owner;
      } else {
        _used[index] = index;
      }

      assert(isDefined(_avail[index]));
      _avail[index] = undefined;
    }

    return index;
  }

  function function_85a5add5() {
    return _used;
  }

  function init(count) {
    assert(_avail.size == 0);
    assert(_used.size == 0);

    for(i = 0; i < count; i++) {
      _avail[i] = i;
    }
  }

}