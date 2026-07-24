/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 3842.gsc
**************************************/

_id_3A20() {
  scripts\engine\utility::flag_init("flag_capt_kill_init");
  scripts\engine\utility::flag_init("flag_capt_killed");
  scripts\engine\utility::flag_init("flag_capt_kill_complete");
  level._effect["capt_kill_breach_explo"] = loadfx("vfx/core/expl/claymore_explosion");
  var_0 = [getEnt("org_capt_kill_charge_1", "targetname"), getEnt("org_capt_kill_charge_2", "targetname")];
  scripts\engine\utility::array_call(var_0, ::hide);
  thread _id_3A11();
}

_id_3A11() {
  scripts\engine\utility::flag_wait("flag_capt_kill_init");
  scripts\sp\utility::_id_2669("outside_capt_kill");
  thread _id_3A0F();
  var_0 = scripts\engine\utility::getStruct("capt_kill_button", "targetname");
  var_0 _id_0E46::_id_48C4(undefined, (0, 0, 0), 0, undefined, 1024);
  var_0 waittill("trigger");
  level.player _meth_80D1();
  level.player thread scripts\sp\utility::_id_CFB8();
  level.player thread _id_3A0D();
  level waittill("capt_kill_explo");
  scripts\sp\utility::_id_22CA("opfor_capt_kill", ::_id_C639);
  level._id_3A10 = scripts\sp\utility::_id_22CD("opfor_capt_kill", 1);
  thread _id_3A0E();
  scripts\engine\utility::flag_clear("flag_breach_wall_compression_done");
  var_1 = scripts\sp\utility::_id_7D80(var_0.origin, scripts\engine\utility::getStructArray("sa_beacon_fx_struct", "targetname"), 1000);
  var_2 = scripts\engine\utility::getStruct("capt_kill_alarm", "targetname");
  scripts\engine\utility::delaythread(0.5, _id_0F01::_id_146F, undefined, var_1, var_2);
  scripts\engine\utility::delaythread(8, scripts\engine\utility::flag_set, "flag_breach_wall_compression_done");
  setslowmotion(1, 0.25, 1);
  wait 3;
  setslowmotion(0.25, 1, 1);
}

_id_3A0D() {
  var_0 = scripts\engine\utility::getStruct("org_capt_kill_breach_setup", "targetname");
  var_1 = scripts\engine\utility::getStruct("org_capt_kill_breach_explo", "targetname");
  var_2 = getEnt("org_capt_kill_charge_1", "targetname");
  var_3 = getEnt("org_capt_kill_charge_2", "targetname");
  self allowstand(1);
  self allowcrouch(0);
  self allowprone(0);
  var_4 = scripts\engine\utility::spawn_tag_origin();
  self playerlinktodelta(var_4, "tag_origin", 1, 4, 4, 4, 4, 0);
  self disableweapons();
  var_4 _id_0F01::_id_117D(var_0, 0.5, 0.0, 0.1);
  wait 0.2;
  var_2 show();
  var_2 thread scripts\sp\utility::play_sound_on_entity("sa_hack_start");
  wait 0.4;
  self allowcrouch(1);
  self allowstand(0);
  wait 0.2;
  var_3 show();
  var_3 thread scripts\sp\utility::play_sound_on_entity("sa_hack_start");
  wait 0.4;
  var_4 _id_0F01::_id_117D(var_1, 0.7, 0.1, 0.1);
  self allowstand(1);
  self allowcrouch(0);
  wait 1.0;
  level notify("capt_kill_explo");
  scripts\engine\utility::exploder("capt_kill_breach");
  var_2 delete();
  var_3 delete();
  var_0 = scripts\engine\utility::getStruct("org_capt_kill_breach_enter", "targetname");
  var_1 = scripts\engine\utility::getStruct("org_capt_kill_breach_end", "targetname");
  self enableweapons();
  var_4 _id_0F01::_id_117D(var_0, 0.4, 0.1, 0.0);
  self unlink();
  self playerlinktodelta(var_4, "tag_origin", 0, 65, 65, 45, 35, 0);
  var_4 _id_0F01::_id_117D(var_1, 1, 0.0, 0.25);
  self allowcrouch(1);
  self allowprone(1);
  self _meth_80A1();
  thread scripts\sp\utility::_id_CFAA();
  self unlink();
  var_4 delete();
}

_id_3A0E() {
  level._id_FD31 thread _id_C63A();
  wait 0.25;
  var_0 = scripts\engine\utility::spawn_tag_origin();
  var_0 linkTo(level._id_FD31, "tag_eye", (0, 0, 20), (0, 0, 0));
  objective_add(scripts\sp\utility::_id_C264("OBJ_CAPTAIN_KILL"), "current", "Kill the ship's captain", var_0.origin);
  objective_setpointertextoverride(scripts\sp\utility::_id_C264("OBJ_CAPTAIN_KILL"), "KILL");
  objective_onentity(scripts\sp\utility::_id_C264("OBJ_CAPTAIN_KILL"), var_0);

  while(level._id_3A10.size > 0) {
    level._id_3A10 = scripts\sp\utility::array_removedeadvehicles(level._id_3A10);
    wait 0.25;
  }

  scripts\engine\utility::flag_set("flag_capt_killed");
  level._id_3A0C waittill("trigger");

  if(!level._id_3A0C scripts\sp\intelligence::_id_3DAD()) {
    level._id_3A0C scripts\sp\intelligence::_id_EB60();
  }

  updategamerprofileall();
  wait 0.05;
  scripts\engine\utility::flag_set("flag_capt_kill_complete");
  level._id_3A0C delete();
  scripts\sp\utility::_id_C27C(scripts\sp\utility::_id_C264("OBJ_CAPTAIN_KILL"));
  var_0 delete();
  scripts\sp\utility::_id_2669("capt_kill_complete");
}

_id_3A0F() {
  scripts\engine\utility::flag_wait("flag_capt_kill_init");
  thread scripts\sp\utility::_id_16C5("Eth.3n", "Marking a structural weakness into the ship's bridge.");
  wait 2;
  thread scripts\sp\utility::_id_16C5("Eth.3n", "Command has cleared a kill order for the captain of this ship.");
  wait 2;
  thread scripts\sp\utility::_id_16C5("Eth.3n", "Action on this order is up to you.");
  scripts\engine\utility::flag_wait("flag_capt_killed");
  wait 0.25;
  thread scripts\sp\utility::_id_16C5("Eth.3n", "Captain Kill Confirmed -- search them for intel.");
  scripts\engine\utility::flag_wait("flag_capt_kill_complete");
  wait 0.25;
  thread scripts\sp\utility::_id_16C5("Eth.3n", "Intel recieved -- continue the ship assault.");
}

_id_C639() {
  self endon("death");
  self._id_1FBB = "generic";

  if(isDefined(self.script_parameters)) {
    var_0 = self.script_parameters == "capt_kill_captain_anim";
    var_1 = issubstr(self.script_parameters, "death");
    var_2 = scripts\engine\utility::getStruct(self.script_parameters, "targetname");

    if(var_0) {
      level._id_FD31 = self;
    }

    var_3 = 0.1;

    if(var_0) {
      var_3 = 1.25;
    }

    if(var_1) {
      self._id_DC1A = 1;
    }

    if(isDefined(self.script_noteworthy)) {
      thread scripts\sp\utility::_id_10346(self.script_noteworthy);
    }

    self.allowdeath = 1;
    var_2 scripts\sp\anim::_id_1ECA(self, self.script_parameters);
    var_2 scripts\sp\anim::_id_1F35(self, self.script_parameters, undefined, var_3, "generic");

    if(var_1) {
      self _meth_81D0();
    }
  }

  if(isDefined(self.target)) {
    thread scripts\sp\utility::_id_7226(getnode(self.target, "targetname"));
  }
}

_id_C63A() {
  self waittill("death");
  var_0 = self.origin;
  var_1 = self.origin;
  level._id_3A0C = spawn("script_model", var_0);
  level._id_3A0C._id_C1D5 = int(tablelookup("sp/intel_items.csv", 3, level.script, 0));
  level._id_3A0C setModel("beacon_intel_tablet");

  for(;;) {
    var_2 = (randomfloatrange(-60, 60), randomfloatrange(-60, 60), 0);
    var_1 = var_0 + var_2;

    if(sighttracepassed(var_1, var_1 + (0, 0, 60), 1, undefined)) {
      break;
    }
  }

  level._id_3A0C.origin = var_1;
  level._id_3A0C _id_0E46::_id_48C4(undefined, (0, 0, 0), 0, undefined, 512);
  objective_setpointertextoverride(scripts\sp\utility::_id_C264("OBJ_CAPTAIN_KILL"), "INTEL");
  objective_onentity(scripts\sp\utility::_id_C264("OBJ_CAPTAIN_KILL"), level._id_3A0C, (0, 0, 12));
}