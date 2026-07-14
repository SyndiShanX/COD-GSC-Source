/****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: hashed\script\script_b90e9249b83faa5.gsc
****************************************************/

#using script_1aae2eb1ef28b239;
#using script_3e31016b9c11a616;
#using script_569138730a0a130f;
#using script_77873e194e406c6d;
#using script_7f9409b703dad400;
#using scripts\common\data_tracker;
#using scripts\common\progress_tracker;
#namespace namespace_699ccc66e99185fb;

function function_8d4642e2c714effc(uniquename, startingprogressvalue, finalprogressvalue, customcallbackfunction) {
  progresstracker = progress_tracker::createprogresstracker(startingprogressvalue, finalprogressvalue);
  function_715585d44e8713ef(uniquename, progresstracker, customcallbackfunction);

  namespace_72e72f5e51e6e4b3::activitynexuslog("<dev string:x24>" + uniquename + "<dev string:x3a>", @ "hash_c6dd0e44e8224971", self);
}

function function_f5d8015556552a75(uniquename, endtimeinseconds, customcallbackfunction) {
  stopwatchprogresstracker = namespace_b0e4e0ee9893e8e2::function_bf2f111a347f5a18(endtimeinseconds);
  function_715585d44e8713ef(uniquename, stopwatchprogresstracker, customcallbackfunction);

  namespace_72e72f5e51e6e4b3::activitynexuslog("<dev string:x58>" + uniquename + "<dev string:x3a>", @ "hash_c6dd0e44e8224971", self);
}

function function_17fc1ab61316b678(uniquename, timeinseconds, customcallbackfunction) {
  countdowntimerprogresstracker = namespace_b0e4e0ee9893e8e2::function_63b6c41cd985e2e7(timeinseconds);
  function_715585d44e8713ef(uniquename, countdowntimerprogresstracker, customcallbackfunction);

  namespace_72e72f5e51e6e4b3::activitynexuslog("<dev string:x78>" + uniquename + "<dev string:x3a>", @ "hash_c6dd0e44e8224971", self);
}

function function_c85d57ad3e716a68(uniquename, var_26b9287cac837583, customcallbackfunction) {
  killprogresstracker = namespace_b0e4e0ee9893e8e2::function_2917692218eb1c27(var_26b9287cac837583);
  function_715585d44e8713ef(uniquename, killprogresstracker, customcallbackfunction);

  namespace_72e72f5e51e6e4b3::activitynexuslog("<dev string:x98>" + uniquename + "<dev string:x3a>", @ "hash_c6dd0e44e8224971", self);
}

function function_ccea0ef4fae043ef() {
  if(namespace_30f3ea5d3d3c7b6c::function_8e30b4ee29db5678()) {
    foreach(progresstracker in self.progresstrackers) {
      function_1f47565f2064bea7(progresstracker);
    }
  }
}

function function_d2b27bff6105c966(uniquename) {
  progresstracker = self.progresstrackers[uniquename];
  assert(isDefined(progresstracker), "<dev string:xb3>" + uniquename + "<dev string:xc5>");
  function_1f47565f2064bea7(progresstracker);
}

function function_a1ad31b41cd24a17(uniquename, pausetimer) {
  progresstracker = self.progresstrackers[uniquename];
  assert(isDefined(progresstracker), "<dev string:x103>" + uniquename + "<dev string:xc5>");
  assert(isDefined(progresstracker.paused), "<dev string:x103>" + uniquename + "<dev string:x117>");

  if(pausetimer && !progresstracker.paused) {
    progresstracker.paused = 1;
    return;
  }

  if(!pausetimer && progresstracker.paused) {
    progresstracker.paused = 0;
    progresstracker notify("~\x18\xa6\xb2\xf0r");
  }
}

function private function_715585d44e8713ef(uniquename, progresstracker, customcallbackfunction) {
  progresstracker progress_tracker::addcallback(self, &function_6524261d8db6be60);

  if(isDefined(customcallbackfunction)) {
    progresstracker progress_tracker::addcallback(self, customcallbackfunction);
  }

  namespace_30f3ea5d3d3c7b6c::addprogresstracker(uniquename, progresstracker);
  data_tracker::adddataprogresstracker(uniquename, progresstracker);
  namespace_59dbf6a1bb28a43f::function_b4d8d495f2e20735(self, uniquename);
}

function private function_6524261d8db6be60(progresstracker) {
  uniquename = progresstracker progress_tracker::getuniquename();
  data_tracker::function_2f2c2a8e9d8a8e67(uniquename);

  namespace_72e72f5e51e6e4b3::activitynexuslog("<dev string:x24>" + uniquename + "<dev string:x152>" + progresstracker progress_tracker::function_608d112a3d06ad0b(), @ "hash_c6dd0e44e8224971", self);

  if(progresstracker progress_tracker::iscomplete()) {
    namespace_72e72f5e51e6e4b3::activitynexuslog("<dev string:x24>" + uniquename + "<dev string:x186>", @ "hash_c6dd0e44e8224971", self);
  }
}

function private function_1f47565f2064bea7(progresstracker) {
  uniquename = progresstracker progress_tracker::getuniquename();
  data_tracker::removedata(uniquename);
  namespace_606113cb7b23f701::function_e2b246aea05de78(uniquename, self.playerparticipants);
  namespace_30f3ea5d3d3c7b6c::endprogresstracker(uniquename);

  namespace_72e72f5e51e6e4b3::activitynexuslog("<dev string:x24>" + uniquename + "<dev string:x197>", @ "hash_c6dd0e44e8224971", self);
}