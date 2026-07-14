/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: hashed\script\script_25bf71578e00560d.gsc
*****************************************************/

#using scripts\common\system;
#using scripts\common\ui;
#using scripts\common\vehicle;
#using scripts\common\vehicle_occupancy;
#using scripts\engine\hud_management;
#using scripts\engine\utility;
#namespace signal_detected;

function private autoexec __init__system__() {
  system::register(#"signal_detected", undefined, undefined, &post_main);
}

function private post_main() {
  thread function_9a70ea8767c5f730();
}

function private function_9a70ea8767c5f730() {
  level utility::flag_wait("\x1b\x9a\xb5p\xb5E\xdfV0\x9b\xe6{\x89\xd1\xd9\xfb\x9ez\xb0P\xf8\xf6AT\xf70w9");
  ui::lui_registercallback("R!ea\xecOwoe\x12Q\xecgp\xab\x15\x94\xa4po\xee", &function_2e71f95df41f559f);
  utility::registersharedfunc(#"signal_detected", #"hash_1ae6fdae3354a581", &function_647e175058f5e92c);
}

function function_f9fb8e4168989e5c(volume, signal_entity, param_name, close_callback) {
  level utility::flag_wait("\x1b\x9a\xb5p\xb5E\xdfV0\x9b\xe6{\x89\xd1\xd9\xfb\x9ez\xb0P\xf8\xf6AT\xf70w9");

  if(!(isDefined(volume) && isDefined(signal_entity))) {
    return;
  }

  dataobj = spawnStruct();
  dataobj.volume = volume;
  dataobj.entitynum = signal_entity getentitynumber();
  dataobj.paramname = param_name ?? "\x91\xca\xcc\v\xab\xd8:";
  dataobj.closecallback = close_callback;
  thread process_radio_signal_volume(dataobj);
}

function private process_radio_signal_volume(dataobj) {
  dataobj.volume notify("\x03U%\xd0\xbf\xda\x12\x97\xfa\xea\x8d\x13W\t\xafP2\x82\xeb\xe0n\xf3\xb0\x82\xd71\x02");
  dataobj.volume endon("\x03U%\xd0\xbf\xda\x12\x97\xfa\xea\x8d\x13W\t\xafP2\x82\xeb\xe0n\xf3\xb0\x82\xd71\x02");
  dataobj.volume endon("\x1e\xfd\xd1\xa2\a");
  dataobj.volume endon("u\xc3vOy=T\xe1\xeel\xe3m\x16K");

  while(true) {
    dataobj.volume waittill("\x91`\xb1\xe7T\x97>");
    function_2abbaedafea0cee4(dataobj.entitynum, dataobj.closecallback, dataobj.paramname);
    self.radio_signal.volume = dataobj.volume;

    while(self istouching(dataobj.volume)) {
      waitframe();
    }

    function_9c1c549cbf76408c(dataobj);
  }
}

function private function_9c1c549cbf76408c(dataobj) {
  if(!hud_management::function_48c98ea9a4f0da89("\xce\xddT\x9c^\x14}>\xf4mm{\x98q\xb2")) {
    return;
  }

  if(self.radio_signal.active_entity == dataobj.entitynum) {
    function_19372fa9e22563bb();
  }
}

function function_2abbaedafea0cee4(entitynum, close_callback, paramname = "\x91\xca\xcc\v\xab\xd8:") {
  assert(isDefined(entitynum));

  if(hud_management::function_48c98ea9a4f0da89("\xce\xddT\x9c^\x14}>\xf4mm{\x98q\xb2")) {
    self.radio_signal.close_callback = close_callback;
    function_56ebb81c90fa75c1(entitynum);
    return;
  }

  self.radio_signal = spawnStruct();
  self.radio_signal.close_callback = close_callback;
  hud_management::function_35924dfcb78711f4("\xce\xddT\x9c^\x14}>\xf4mm{\x98q\xb2", "Y\xb1\x1b\x02*W{1\xfbv\tq:\x7fk\x02\x98\xb8WT-\xd9@\xd8\xdeG\xc9~\x98\xfb\a");
  hud_management::function_b683400f784cb7dc("\xce\xddT\x9c^\x14}>\xf4mm{\x98q\xb2", paramname);
  function_56ebb81c90fa75c1(entitynum);
  hud_management::function_85d8a0ba2e35b6f2("\xce\xddT\x9c^\x14}>\xf4mm{\x98q\xb2", 0, 220, 1, 0);
}

function function_56ebb81c90fa75c1(entitynum) {
  assert(hud_management::function_48c98ea9a4f0da89("<dev string:x24>"));
  self.radio_signal.active_entity = entitynum;
  hud_management::function_d3b457baa69dec73("\xce\xddT\x9c^\x14}>\xf4mm{\x98q\xb2", "4z\x1c\x05\x93OSA\x7f^B\xd2\x80\xd0\xfc\xba\xb6{\xa5\x8a", entitynum);
  hud_management::function_7327dfb1da700659("\xce\xddT\x9c^\x14}>\xf4mm{\x98q\xb2", gettime());
}

function function_19372fa9e22563bb() {
  assert(hud_management::function_48c98ea9a4f0da89("<dev string:x24>"));
  hud_management::function_d3b457baa69dec73("\xce\xddT\x9c^\x14}>\xf4mm{\x98q\xb2", "r\x11\xfe\xbd\xc0\xb1L&\xdd\x87N\t9\x1d", 1);
  hud_management::function_7327dfb1da700659("\xce\xddT\x9c^\x14}>\xf4mm{\x98q\xb2", gettime());
}

function function_647e175058f5e92c() {
  if(isDefined(self.radio_signal)) {
    if(isDefined(self.radio_signal.volume)) {
      self.radio_signal.volume delete();
    }

    function_2e71f95df41f559f();
  }
}

function function_2e71f95df41f559f(value) {
  if(isDefined(self.radio_signal) && isDefined(self.radio_signal.close_callback)) {
    self thread[[self.radio_signal.close_callback]]();
  }

  self.radio_signal.volume notify("u\xc3vOy=T\xe1\xeel\xe3m\x16K");
  hud_management::scripted_widget_destroy("\xce\xddT\x9c^\x14}>\xf4mm{\x98q\xb2");
  self.radio_signal = undefined;
}

function function_174bd3a0b78e1fd5() {
  level endon("\xeb\xefA\xb3\x9f\xbe\x02$\xa0\xa7");
  self endon("\x1e\xfd\xd1\xa2\a");
  radio_data = self.radio_data;

  while(true) {
    self waittill("\x91`\xb1\xe7T\x97>", ent);
    ent_id = ent getentitynumber();

    if(isDefined(radio_data.registered_players[ent_id])) {
      continue;
    }

    if(!isPlayer(ent) && !ent vehicle::is_vehicle()) {
      continue;
    }

    if(ent vehicle::is_vehicle()) {
      occupants = vehicle_occupancy::function_6a313c647192af3(ent);

      foreach(occupant in occupants) {
        if(isPlayer(occupant)) {
          occupant_id = occupant getentitynumber();

          if(isDefined(radio_data.registered_players[occupant_id])) {
            continue;
          }

          radio_data.registered_players[occupant_id] = occupant;
          occupant function_2abbaedafea0cee4(radio_data.entitynum, radio_data.closecallback, radio_data.paramname);
          occupant.radio_signal.volume = radio_data.volume;
          occupant thread function_9a6e3f410f0ba312(radio_data);
        }
      }

      continue;
    }

    radio_data.registered_players[ent_id] = ent;
    ent function_2abbaedafea0cee4(radio_data.entitynum, radio_data.closecallback, radio_data.paramname);
    ent.radio_signal.volume = radio_data.volume;
    ent thread function_9a6e3f410f0ba312(radio_data);
  }
}

function private function_9a6e3f410f0ba312(radio_data) {
  level endon("\xeb\xefA\xb3\x9f\xbe\x02$\xa0\xa7");
  radio_data.volume endon("\x1e\xfd\xd1\xa2\a");

  while(isalive(self)) {
    if(!self istouching(radio_data.volume)) {
      break;
    }

    waitframe();
  }

  function_1dd2c9d405cabcfd(radio_data);
}

function private function_1dd2c9d405cabcfd(radio_data) {
  radio_data.registered_players[self getentitynumber()] = undefined;
  function_9c1c549cbf76408c(radio_data);
}