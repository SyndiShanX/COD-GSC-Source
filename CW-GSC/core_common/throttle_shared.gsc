/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
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
    updaterate_ = 0.05;
  }

  function wm_ht_posidlestart(entity) {
    return isinarray(queue_, entity);
  }

  function private _updatethrottlethread(throttle) {
    while(isDefined(throttle)) {
      [[throttle]] - > _updatethrottle();
      wait throttle.updaterate_;
    }
  }

  function initialize(processlimit, updaterate) {
    processlimit_ = processlimit;
    updaterate_ = updaterate;
    self thread _updatethrottlethread(self);
  }

  function leavequeue(entity) {
    arrayremovevalue(queue_, entity);
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

  function private function_f629508d(throttle) {
    while(isDefined(throttle)) {
      [[throttle]] - > function_eba90b67();
      wait throttle.updaterate_;
    }
  }

}
class class_c6c0e94 {
  var processlimit_;
  var queue_;
  var queuelimit_;
  var updaterate_;
  var var_53070152;

  constructor() {
    queue_ = [];
    processlimit_ = 1;
    updaterate_ = 0.05;
  }

  function wm_ht_posidlestart(entity) {
    return isinarray(queue_, entity);
  }

  function initialize(name, processlimit, updaterate, queuelimit) {
    processlimit_ = processlimit;
    updaterate_ = updaterate;
    var_53070152 = name + "_wake_up";
    queuelimit_ = queuelimit;
    self thread throttle::function_f629508d(self);
  }

  function leavequeue(entity) {
    arrayremovevalue(queue_, entity);
  }

  function waitinqueue(entity) {
    while(isDefined(queuelimit_) && queue_.size > queuelimit_) {
      function_eba90b67();
    }

    if(!isDefined(entity)) {
      return;
    }

    if(!isentity(entity) && !isstruct(entity)) {
      return;
    }

    if(!isinarray(queue_, entity)) {
      queue_[queue_.size] = entity;
    }

    entity endon(#"death", #"delete");
    entity waittill(var_53070152);
  }

  function private function_eba90b67() {
    arrayremovevalue(queue_, undefined);
    processed = 0;

    foreach(item in queue_) {
      if(!isDefined(item)) {
        continue;
      }

      arrayremovevalue(queue_, item);
      item notify(var_53070152);
      processed++;

      if(processed >= processlimit_) {
        break;
      }
    }
  }
}