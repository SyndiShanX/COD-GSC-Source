/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp_mp\oxygenmask.gsc
***********************************************/



#using scripts\common\swim_common;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\cp_mp\entityheadicons;
#using scripts\cp_mp\utility\inventory_utility;
#using scripts\cp_mp\utility\player_utility;
#using scripts\cp_mp\utility\weapon_utility;
#using scripts\cp_mp\vehicles\vehicle_occupancy;
#using scripts\engine\utility;
#using scripts\mp\utility\lower_message;
#namespace oxygenmask;

function function_234851f94416f178() {
  level.var_f6bad8618358a031 = spawnStruct();
  level.var_f6bad8618358a031.holdweaponname = "iw9_oxygenmask";
  level.var_f6bad8618358a031.var_1df8739f84d611ae = 99;

  if(issharedfuncdefined("oxygenmask", "init")) {
    [[getsharedfunc("oxygenmask", "init")]]();
  }
}

function give_oxygenmask() {
  if(istrue(self.var_23a6763562820c70) && iscp()) {
    return false;
  }

  thread function_80143a61b671bdd3();
  return true;
}

function function_23a6763562820c70() {
  return istrue(self.var_23a6763562820c70);
}

function oxygenmask_tryshowhint() {
  level endon("game_ended");
  self endon("death_or_disconnect");
  self notify("oxygenmask_tryShowHint");
  self endon("oxygenmask_tryShowHint");

  if(!isDefined(level.var_f6bad8618358a031.hintsplayed)) {
    level.var_f6bad8618358a031.hintsplayed = [];
  }

  hintdata = level.var_f6bad8618358a031.hintsplayed;
  entnum = self getentitynumber();

  if(!isDefined(hintdata[entnum])) {
    hintdata[entnum] = 0;
  }

  nummsg = getdvarint(@ "hash_cfa01cde7d01c1e2", 1);

  if(nummsg <= hintdata[entnum]) {
    return;
  }

  scripts\mp\utility\lower_message::setlowermessageomnvar("rebreather_hint");
  wait 5;
  scripts\mp\utility\lower_message::setlowermessageomnvar("clear_lower_msg");
  hintdata[entnum]++;
  level.var_f6bad8618358a031.hintsplayed = hintdata;
}

function function_8fc85383e9f1b6e6() {
  if(istrue(self.var_23a6763562820c70)) {
    announcement("<dev string:x1c>");

    if(soundexists("cp_oxygenmask_hiss")) {
      playsoundatpos(self.origin, "cp_oxygenmask_hiss");
    }

    thread function_a51cb31233eacf9e();

    if(isDefined(self.var_72f72f6558f6a22a)) {
      self.var_72f72f6558f6a22a delete();
    }

    return true;
  }

  return false;
}

function private function_80143a61b671bdd3() {
  self endon("disconnect");
  self endon("game_ended");
  self endon("drop_oxygenmask");
  self notify("give_oxygenmask");
  self endon("give_oxygenmask");
  currweapon = self getcurrentweapon();

  if(currweapon.basename != "none") {
    if(getdvarint(@ "hash_44f86dd3c04fba8f", 0)) {
      if(scripts\common\utility::iscp()) {
        self forceplaygestureviewmodel("ges_magma_gas_mask_on");
      } else {
        self forceplaygestureviewmodel("ges_visor_down");
      }
    }
  }

  if(scripts\common\utility::iscp()) {
    scripts\common\values::set("oxygenmask", "weapon_switch", 0);
    scripts\common\values::set("oxygenmask", "melee", 0);
    scripts\common\values::set("oxygenmask", "equipment_primary", 0);
    scripts\common\values::set("oxygenmask", "equipment_secondary", 0);
    scripts\common\values::set("oxygenmask", "weapon_pickup", 0);
  }

  thread oxygenmask_tryshowhint();
  function_2f21b35828315a0(0);

  if(issharedfuncdefined("oxygenmask", "onGive")) {
    self[[getsharedfunc("oxygenmask", "onGive")]]();
  }

  self.var_23a6763562820c70 = 1;
  self.var_c0eb949c54277b2c = undefined;

  if(scripts\common\utility::iscp()) {
    scripts\common\swim_common::function_a05de828303d4bed();
    childthread scripts\common\swim_common::function_8c3428aeb7c8b1f4(10);
    function_c2ee77402d52be9(level.var_f6bad8618358a031.holdweaponname);
    wait 0.5;
  }

  thread oxygenmask_handle_death();

  if(issharedfuncdefined("oxygenmask", "onEquip")) {
    [[getsharedfunc("oxygenmask", "onEquip")]]();
  }

  function_7823f77f978a3360();
}

function function_7823f77f978a3360() {
  self endon("disconnect");
  self endon("game_ended");
  self endon("drop_oxygenmask");
  self endon("give_oxygenmask");

  while(true) {
    wait 0.05;
    can_use = function_67506c2318ca4da2();
    trying = function_27e7b88ea18125f();
    var_d45ca71a300e2c90 = isDefined(self getcurrentweapon()) && is_equal(self getcurrentweapon().var_9d7facbe889e667c, %"iw9_oxygenmask");
    nonplayerstate = isDefined(self.vehicle) && scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getdriver(self.vehicle) == self || isusingremote();

    if(!var_d45ca71a300e2c90 && !nonplayerstate) {
      thread function_a51cb31233eacf9e();
    }

    if(trying && can_use) {
      function_44524a0826f0975a(1);
      function_eae1981ab021806b();
      continue;
    }

    if(trying && !can_use) {
      function_44524a0826f0975a(0);

      if(issharedfuncdefined("oxygenmask", "onUnusable")) {
        self thread[[getsharedfunc("oxygenmask", "onUnusable")]]();
      }

      continue;
    }

    if(can_use && !trying) {
      function_44524a0826f0975a(1);

      if(iscp()) {
        function_8b61dac63b58c6ce("Ready");
      }

      continue;
    }

    function_44524a0826f0975a(0);

    if(iscp()) {
      function_8b61dac63b58c6ce("Not Usable");
    }
  }
}

function function_2e4cd4d627c30c24() {
  return give_oxygenmask();
}

function private function_2c9c3bc278844056() {}

function private function_44524a0826f0975a(toggle) {
  if(isDefined(self.var_9c26d9c1ec7fdc65) && self.var_9c26d9c1ec7fdc65 == toggle) {
    return;
  }

  self.var_9c26d9c1ec7fdc65 = toggle;

  if(istrue(toggle)) {
    scripts\common\values::reset_all("oxygenmask_canfire");
    return;
  }

  scripts\common\values::set("oxygenmask_canfire", "fire", 0);
}

function private function_2f21b35828315a0(toggle) {
  if(isDefined(self.var_58a1bd2c2c9338ad) && self.var_58a1bd2c2c9338ad == toggle) {
    return;
  }

  self.var_58a1bd2c2c9338ad = toggle;

  if(istrue(toggle)) {
    scripts\common\values::reset_all("oxygenmask_canads");
    return;
  }

  scripts\common\values::set("oxygenmask_canads", "ads", 0);
}

function private function_c2ee77402d52be9(holdweapon) {
  self.var_9a46747153a02d2f = self getcurrentweapon();
  var_4c31d0690f7e6d1d = makeweapon(holdweapon);
  _giveweapon(var_4c31d0690f7e6d1d);
  self switchtoweaponimmediate(var_4c31d0690f7e6d1d);
}

function private givedeployweapon(deployweaponname) {
  self endon("death_or_disconnect");

  if(self isgestureplaying()) {
    self stopgestureviewmodel();
  }

  if(self isviewmodelanimplaying()) {
    self stopviewmodelanim();
  }

  objweapon = makeweapon(deployweaponname);
  result = giveandfireoffhandreliable(objweapon);
  return result;
}

function function_8b61dac63b58c6ce(state) {
  if(self.var_fe2b9ee0479ad3cf != state) {
    self.var_fe2b9ee0479ad3cf = state;
    self notify("oxygenmask_changestate");
  }
}

function function_ddd53cc3c592bd02() {
  if(!isDefined(self.var_fe2b9ee0479ad3cf)) {
    return "";
  }

  return self.var_fe2b9ee0479ad3cf;
}

function private oxygenmask_handle_death() {
  self endon("disconnect");
  self notify("oxygenmask_handle_death");
  self endon("oxygenmask_handle_death");
  self waittill("death");

  if(!istrue(self.var_23a6763562820c70)) {
    return;
  }

  if(iscp()) {
    self.var_72f72f6558f6a22a delete();
  }

  thread function_a51cb31233eacf9e();
  self waittill("spawned_player");
  wait 1;
  give_oxygenmask();
}

function function_a51cb31233eacf9e() {
  self notify("drop_oxygenmask");
  scripts\common\values::reset_all("oxygenmask");
  scripts\common\values::reset_all("oxygenmask_canfire");
  scripts\common\values::reset_all("oxygenmask_canads");

  if(issharedfuncdefined("oxygenmask", "onRemove")) {
    [[getsharedfunc("oxygenmask", "onRemove")]]();
  }

  self.var_23a6763562820c70 = undefined;
  self.var_a3bde3b734d04764 = undefined;
  self.var_58a1bd2c2c9338ad = undefined;
  self.var_9c26d9c1ec7fdc65 = undefined;
  currweapon = self getcurrentweapon();

  if(currweapon.basename != "none") {
    if(getdvarint(@ "hash_44f86dd3c04fba8f", 0)) {
      if(scripts\common\utility::iscp()) {
        self forceplaygestureviewmodel("ges_magma_gas_mask_off");
        return;
      }

      self forceplaygestureviewmodel("ges_visor_up");
    }
  }
}

function private function_27e7b88ea18125f() {
  if(self attackButtonPressed() || self buttonPressed("MOUSE1") || istrue(self.var_af23415abf13e8fa) && isswimmingunderwater()) {
    return true;
  }

  return false;
}

function private function_67506c2318ca4da2() {
  if(!_isalive()) {
    return false;
  }

  if(istrue(self.inlaststand)) {
    return false;
  }

  if(getdvarint(@ "hash_73621d9d9f54e301", 0)) {
    return true;
  }

  if(!self isswimunderwater()) {
    return false;
  }

  if(self isswimsprinting()) {
    return false;
  }

  if(self israisingweapon()) {
    return false;
  }

  if(!isnullweapon(self getheldoffhand())) {
    return false;
  }

  if(istrue(self.var_a3bde3b734d04764)) {
    return false;
  }

  if(istrue(self.var_c0eb949c54277b2c)) {
    return false;
  }

  if(istrue(level.var_ec0baa43406de34a)) {
    return false;
  }

  if(istrue(self.var_8d47f4af9323f11e)) {
    return false;
  }

  if(isDefined(self.var_984bd769a1e0201e)) {
    usetime = 4000;

    if(gettime() < self.var_984bd769a1e0201e + usetime) {
      return false;
    }
  }

  return true;
}

function private function_bc75520a8c4707ba() {
  return getdvarfloat(@ "hash_c5320528e750d996", 0.75);
}

function private function_eae1981ab021806b() {
  self endon("death");
  self endon("oxygenmask_fail");
  function_2f21b35828315a0(1);

  if(issharedfuncdefined("oxygenmask", "onUse")) {
    [[getsharedfunc("oxygenmask", "onUse")]]();
  }

  self.var_a3bde3b734d04764 = 1;
  self.var_af23415abf13e8fa = undefined;
  self.var_984bd769a1e0201e = gettime();
  self playlocalsound("plr_breath_pain_init");
  thread function_1ab4e7e73ad0c18e();
  thread function_5ec8d8473d72b73();
  thread function_2c9c3bc278844056();
  self notify("used_oxygen_mask");
  level notify("used_oxygen_mask", self);
  returnmsg = waittill_notify_or_timeout_return("weapon_fired", 4);

  if(returnmsg == "weapon_fired") {
    thread function_95812dcc553470bd();
  }

  self notify("oxygenmask_fired");
  function_9ac10cec8e7b9d40();

  if(issharedfuncdefined("oxygenmask", "onUseComplete")) {
    self[[getsharedfunc("oxygenmask", "onUseComplete")]]();
  }

  if(getdvarint(@ "hash_1280ac8ef0dd0e07", 0)) {
    self waittill("can_use_mask_now");
  }

  while(function_27e7b88ea18125f()) {
    wait 0.05;
  }
}

function function_1ab4e7e73ad0c18e() {
  self endon("oxygenmask_fail");
  self endon("drop_oxygenmask");
  self endon("death_or_disconnect");
  level endon("game_ended");
  wait 3.32;
  thread function_44524a0826f0975a(0);
}

function function_9ac10cec8e7b9d40() {
  self.var_a3bde3b734d04764 = 0;
  function_2f21b35828315a0(0);
}

function private function_87a62a5519055b00() {
  self endon("death");
  delay = 1;

  if(istrue(self.var_d988fa5d07c2a5bd)) {
    delay = 0.1;
  }

  self.var_d988fa5d07c2a5bd = 1;
  wait delay;
  self stopforcedfire();
}

function private enable_headicon() {
  icon = "hud_icon_equipment_oxygen";
  offset = 16;
  drawwalls = 1;
  toshowto = [];

  if(level.players.size == 1) {
    return;
  }

  for(i = 0; i < level.players.size; i++) {
    if(level.players[i] != self) {
      toshowto[toshowto.size] = level.players[i];
    }
  }

  self.var_afd8a16fcba5b91 = scripts\cp_mp\entityheadicons::setheadicon_singleimage(toshowto, icon, offset, 0, 512, 100, 0, 0, drawwalls, undefined, 1);
}

function private disable_headicon() {
  if(isDefined(self.var_afd8a16fcba5b91)) {
    scripts\cp_mp\entityheadicons::setheadicon_deleteicon(self.var_afd8a16fcba5b91);
    self.var_afd8a16fcba5b91 = undefined;
  }
}

function private debug_allow_shoot_while_ufoing() {
  level endon("game_ended");
  self endon("death_or_disconnect");
  self endon("drop_oxygenmask");
  currentstate = 0;

  while(true) {
    if(self isufo() && currentstate == 0) {
      currentstate = 1;
      scripts\common\values::reset_all("debug_allow_shoot_while_ufoing");
    } else if(!self isufo() && currentstate == 1) {
      currentstate = 0;
      scripts\common\values::set("debug_allow_shoot_while_ufoing", "fire", 0);
    }

    wait 0.05;
  }
}

function private function_95812dcc553470bd() {
  self endon("disconnect");
  level endon("game_ended");
  self endon("give_oxygenmask");
  var_96da5f505495f48a = getdvarint(@ "hash_dbb8c128e4b02706", level.var_f6bad8618358a031.var_1df8739f84d611ae);
  scripts\common\swim_common::function_8c3428aeb7c8b1f4(var_96da5f505495f48a, &function_bc75520a8c4707ba);
}

function private function_5ec8d8473d72b73() {
  self endon("disconnect");
  level endon("game_ended");
  self startforcedfire();

  if(iscp()) {
    childthread function_87a62a5519055b00();
    return;
  }

  waittill_any_2("oxygenmask_fail", "oxygenmask_fired");
  self stopforcedfire();
}