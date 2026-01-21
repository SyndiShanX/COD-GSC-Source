/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: shared\throttle_shared.gsc
*************************************************/

class throttle {
  var processed_;
  var processlimit_;
  var queue_;
  var updaterate_;

  constructor() {
    queue_ = [];
    processed_ = 0;
    processlimit_ = 1;
    updaterate_ = 0.05;
  }

  destructor() {}

  function waitinqueue(entity) {
    if(processed_ >= processlimit_) {
      queue_[queue_.size] = entity;
      firstinqueue = 0;
      while(!firstinqueue) {
        if(!isDefined(entity)) {
          return;
        }
        if(processed_ < processlimit_ && queue_[0] === entity) {
          firstinqueue = 1;
          queue_[0] = undefined;
        } else {
          wait(updaterate_);
        }
      }
    }
    processed_++;
  }

  function initialize(processlimit = 1, updaterate = 0.05) {
    processlimit_ = processlimit;
    updaterate_ = updaterate;
    self thread _updatethrottlethread(self);
  }

  function private _updatethrottle() {
    processed_ = 0;
    currentqueue = queue_;
    queue_ = [];
    foreach(item in currentqueue) {
      if(isDefined(item)) {
        queue_[queue_.size] = item;
      }
    }
  }

  function private _updatethrottlethread(throttle) {
    while(isDefined(throttle)) {
      [[throttle]] - > _updatethrottle();
      wait(throttle.updaterate_);
    }
  }

}