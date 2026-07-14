/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: hashed\script\script_7f9409b703dad400.gsc
*****************************************************/

#using scripts\common\progress_tracker;
#using scripts\engine\utility;
#namespace namespace_b0e4e0ee9893e8e2;

function function_bf2f111a347f5a18(endtimeinseconds, var_154d010173d57f38) {
  stopwatchprogresstracker = progress_tracker::createprogresstracker(0, endtimeinseconds);

  if(!isDefined(var_154d010173d57f38)) {
    var_154d010173d57f38 = 0.25;
  }

  stopwatchprogresstracker.paused = 0;
  stopwatchprogresstracker thread function_26a04331ee64f3b3(0, var_154d010173d57f38);
  return stopwatchprogresstracker;
}

function function_63b6c41cd985e2e7(timeinseconds, var_154d010173d57f38) {
  countdowntimerprogresstracker = progress_tracker::createprogresstracker(timeinseconds, 0);

  if(!isDefined(var_154d010173d57f38)) {
    var_154d010173d57f38 = 0.25;
  }

  countdowntimerprogresstracker.paused = 0;
  countdowntimerprogresstracker thread function_26a04331ee64f3b3(1, var_154d010173d57f38);
  return countdowntimerprogresstracker;
}

function function_2917692218eb1c27(var_26b9287cac837583, var_154d010173d57f38) {
  killprogresstracker = progress_tracker::createprogresstracker(0, var_26b9287cac837583.size);

  if(!isDefined(var_154d010173d57f38)) {
    var_154d010173d57f38 = 0.5;
  }

  killprogresstracker thread function_ca3309c8acc2a3d2(var_26b9287cac837583, var_154d010173d57f38);
  return killprogresstracker;
}

function function_26a04331ee64f3b3(shoulddecrement, var_154d010173d57f38) {
  self endon("\xcbAoe\x18\xdf\x11{\xb9e\xaf\x05'=\x88:\x8a\x9b\xb1\xe7\xf5\xbe\xe0\x1b\x02t\xce");
  var_a1196f031fda9b46 = gettime();

  while(!progress_tracker::iscomplete()) {
    var_5cddad9708503a49 = gettime();
    timepassedinseconds = (var_5cddad9708503a49 - var_a1196f031fda9b46) / 1000;
    var_a1196f031fda9b46 = var_5cddad9708503a49;

    if(istrue(shoulddecrement)) {
      progress_tracker::decrementcurrentprogress(timepassedinseconds);
    } else {
      progress_tracker::incrementcurrentprogress(timepassedinseconds);
    }

    if(self.paused) {
      self waittill("~\x18\xa6\xb2\xf0r");
      var_a1196f031fda9b46 = gettime();
    }

    wait var_154d010173d57f38;
  }
}

function function_ca3309c8acc2a3d2(var_26b9287cac837583, var_154d010173d57f38) {
  self endon("\xcbAoe\x18\xdf\x11{\xb9e\xaf\x05'=\x88:\x8a\x9b\xb1\xe7\xf5\xbe\xe0\x1b\x02t\xce");
  enemiesremaining = var_26b9287cac837583.size;

  while(!progress_tracker::iscomplete()) {
    var_26b9287cac837583 = var_26b9287cac837583 utility::function_9b645290bcb05f87(var_26b9287cac837583);

    if(var_26b9287cac837583.size < enemiesremaining) {
      recentkills = enemiesremaining - var_26b9287cac837583.size;
      progress_tracker::incrementcurrentprogress(recentkills);
      enemiesremaining = var_26b9287cac837583.size;
    }

    wait var_154d010173d57f38;
  }
}