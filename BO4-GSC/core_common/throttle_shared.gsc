/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: core_common\throttle_shared.gsc
***********************************************/

#namespace throttle;

class throttle {
  var processed_;
  var processlimit_;
  var queue_;
  var updaterate_;
  var var_3cd6b18f;

  constructor() {
    queue_ = [];
    processed_ = 0;
    processlimit_ = 1;
    var_3cd6b18f = [];
    updaterate_ = float(function_60d95f53()) / 1000;
  }

  function leavequeue(entity) {
    arrayremovevalue(queue_, entity);
  }

  function wm_ht_posidlestart(entity) {
    return isinarray(queue_, entity);
  }

  function waitinqueue(entity = randomint(2147483647)) {
    if(processed_ >= processlimit_) {
      nextqueueindex = queue_.size < 0 ? 0 : getlastarraykey(queue_) + 1;
      queue_[nextqueueindex] = entity;
      firstinqueue = 0;

      while(!firstinqueue) {
        if(!isDefined(entity)) {
          return;
        }

        firstqueueindex = getfirstarraykey(queue_);

        if(processed_ < processlimit_ && queue_[firstqueueindex] === entity) {
          firstinqueue = 1;
          queue_[firstqueueindex] = undefined;
          continue;
        }

        var_3cd6b18f[var_3cd6b18f.size] = entity;
        wait updaterate_;
      }
    }

    processed_++;
  }

  function initialize(processlimit = 1, updaterate = float(function_60d95f53()) / 1000) {
    processlimit_ = processlimit;
    updaterate_ = updaterate;
    self thread _updatethrottlethread(self);
  }

  function private _updatethrottle() {
    processed_ = 0;
    currentqueue = queue_;
    queue_ = [];

    foreach(item in currentqueue) {
      if(!isDefined(item)) {
        continue;
      }

      foreach(var_fe3b6341 in var_3cd6b18f) {
        if(item === var_fe3b6341) {
          queue_[queue_.size] = item;
          break;
        }
      }
    }

    var_3cd6b18f = [];
  }

  function private _updatethrottlethread(throttle) {
    while(isDefined(throttle)) {
      [
        [throttle]
      ] - > _updatethrottle();
      wait throttle.updaterate_;
    }
  }

}