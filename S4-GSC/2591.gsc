/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 2591.gsc
*************************************************/

_id_7154(var_0) {
  self endon("disconnect");
  var_0 endon("death");
  thread _id_1FBF(var_0);
}

_id_1FBF(var_0) {
  var_0 thread scripts\mp\utility\script::_id_A695("death", "end_explode");
  var_0 endon("end_explode");
  var_0 waittill("explode", var_1);
  thread _id_A6C7(var_1);
}

_id_A6C7(var_0) {
  level endon("white_phosphorus_end");
  level endon("game_ended");
  var_1 = spawnStruct();
  var_1._id_4315 = var_0;
  var_1._id_5C71 = var_0;
  var_2 = spawn("script_model", var_1._id_5C71);
  var_2 setModel("equip_smoke_gbr_n77_mp");
  var_2.owner = self;
  var_2.team = self.team;
  var_2._id_EA6A = var_1;
  var_2.weapon_name = "s4_firebombing_run_mp";
  var_2._id_4346 = _id_0817::_id_1135(var_0, 85, 200, var_2.owner.team, 10, var_2.owner, 1);
  var_3 = scripts\engine\trace::ray_trace(var_0, var_0 - (0, 0, 10000), self, undefined, 1, 1);
  var_4 = var_3["surfacetype"];
  var_2 thread _id_09BE::_id_10F94("burn");
  var_2 thread _id_10F7C(10, "burn", var_4);
}

_id_10F7C(var_0, var_1, var_2) {
  self endon("death");
  level endon("white_phosphorus_end");
  level endon("game_ended");
  self._id_BDA3 = 1;
  level _id_09BE::_id_10F5A("inner", self);
  self setscriptablepartstate("impact", "on", 0);

  if(isDefined(var_2) && var_2 == "surftype_water") {
    self setscriptablepartstate("flare_death_water", "on", 0);
  } else {
    self setscriptablepartstate("flare", "on", 0);
  }

  var_3 = self._id_EA6A._id_4315 + (0, 0, 10);

  if(isDefined(self.owner)) {
    self.owner radiusdamage(var_3, 85, 17, 17, self.owner, "MOD_EXPLOSIVE", "s4_smoke_gbr_n77_mp");
  }

  if(isDefined(var_2) && var_2 != "surftype_water") {
    if(isDefined(var_1)) {
      self.killcament = spawn("script_model", self.origin + (0, 0, 100));

      if(var_1 == "burn") {
        thread _id_09BE::_id_10F8F(85, "s4_smoke_gbr_n77_mp");
      } else {
        thread _id_09BE::_id_10F8E(85);
      }
    }

    scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(var_0);
    self notify("stop_wp_status_effect");
    level _id_09BE::_id_10F7D("inner", self, var_1, 1);

    if(isDefined(self._id_4346)) {
      self._id_4346 = undefined;
    }

    self setscriptablepartstate("flare", "off", 0);
    self setscriptablepartstate("flare_death", "on", 0);
  }

  if(isDefined(self.killcament)) {
    self.killcament delete();
  }
}

_id_10F6C(var_0, var_1) {
  level endon("white_phosphorus_end");
  level endon("game_ended");

  if(!isDefined(self._id_B7B9)) {
    self._id_B7B9 = [];
  }

  if(!isDefined(self._id_B7C9)) {
    self._id_B7C9 = [];
  }

  var_2 = 0;
  var_4 = 0;

  if(var_4) {
    var_5 = _func_03C5("equip_smoke_gbr_n77_mp", var_0, self.angles);
  } else {
    var_5 = spawn("script_model", var_0);
    var_5 setModel("ks_white_phosphorus_mp");
    var_5 setentityowner(self.owner);
  }

  var_5.team = self.team;
  var_5.owner = self;
  var_5 thread _id_09BE::_id_10F98();
  level thread _id_09BE::_id_10F7B(var_5);

  if(scripts\cp_mp\utility\game_utility::isnightmap() || scripts\cp_mp\utility\game_utility::_id_894E()) {
    var_5 setscriptablepartstate("smoke_night", "on", 0);
  } else {
    var_5 setscriptablepartstate("smoke", "on", 0);
  }

  var_5 thread _id_09BE::_id_10F90(85, var_2, undefined, "s4_smoke_gbr_n77_mp");
  level _id_09BE::_id_10F5A("smoke", var_5);
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(var_1);
  level _id_09BE::_id_10F7D("smoke", var_5);
}