/************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: 3574.gsc
************************/

init() {
  level.var_C7E4 = loadfx("vfx\core\mp\ability\vfx_aslt_overcharge_scrn");
  level.var_C7E5 = loadfx("vfx\core\mp\ability\vfx_aslt_overcharge_world_view");
  scripts\mp\powerloot::func_DF06("power_overCharge", ["passive_increased_duration", "passive_fire_damage", "passive_overcharge_recoil"]);
}

func_E14D(param_00, param_01) {
  self endon("death");
  self endon("disconnect");
  level endon("game_ended");
  for(var_02 = scripts\mp\powers::damageconetrace(param_00) / 1000; var_02 > 0; var_02 = scripts\mp\powers::damageconetrace(param_00) / 1000) {
    wait(var_02);
  }

  self playlocalsound("mp_overcharge_off");
  func_E14C(param_01);
}

func_E14C(param_00) {
  if(!isDefined(param_00)) {
    param_00 = 0;
  }

  if(isDefined(self.var_C7E6) && self.var_C7E6) {
    self notify("removeOvercharge");
    self.var_C7E8 = undefined;
    scripts\mp\weapons::updateviewkickscale();
    func_E12D();
    self.powers["power_overCharge"].var_19 = 0;
    self.var_C7E6 = undefined;
    scripts\mp\utility::removeperk("specialty_overcharge");
    var_01 = scripts\mp\powerloot::func_D779("power_overCharge", "passive_overcharge_recoil");
    if(var_01) {
      scripts\mp\utility::setrecoilscale(0);
    }

    if(param_00) {
      scripts\mp\utility::removeperk("passive_fire_damage");
    }
  }
}

useovercharge() {
  self endon("death");
  self endon("disconnect");
  self endon("removeOvercharge");
  level endon("game_ended");
  self.var_C7E6 = 1;
  self.powers["power_overCharge"].var_19 = 1;
  var_00 = scripts\mp\powerloot::func_7FC1("power_overCharge", 5);
  var_01 = scripts\mp\powerloot::func_D779("power_overCharge", "passive_fire_damage");
  var_02 = scripts\mp\utility::_hasperk("passive_fire_damage");
  var_03 = var_01 && !var_02;
  if(var_03) {
    scripts\mp\utility::giveperk("passive_fire_damage");
  }

  self playlocalsound("mp_overcharge_on");
  thread func_20CE();
  thread func_20D3();
  thread func_20D4();
  scripts\mp\utility::giveperk("specialty_overcharge");
  var_04 = "power_overCharge_update";
  self.var_C7E8 = 0;
  scripts\mp\weapons::updateviewkickscale();
  thread scripts\mp\powers::func_4575(var_00, var_04, "removeOvercharge");
  thread func_E14D(var_04, var_03);
}

func_20D4() {
  self endon("death");
  self endon("disconnect");
  self endon("removeOvercharge");
  level endon("game_ended");
  var_00 = anglestoup(self.angles);
  var_01 = anglesToForward(self.angles);
  for(;;) {
    playFX(level.var_C7E5, self.origin + (0, 0, 25), var_01, var_00);
    wait(0.1);
  }
}

func_20D3() {
  self endon("death");
  self endon("disconnect");
  self endon("removeOvercharge");
  var_00 = scripts\mp\powerloot::func_D779("power_overCharge", "passive_overcharge_recoil");
  if(var_00) {
    scripts\mp\utility::setrecoilscale(0, 25);
  }

  for(;;) {
    self waittill("weapon_fired", var_01);
    var_02 = self getweaponammoclip(var_01);
    self.var_C7E7.origin = self getEye();
    triggerfx(self.var_C7E7);
    self playlocalsound("overcharge_fire_plr");
    self.var_C7E7 playsoundtoteam("overcharge_fire_npc", "axis", self);
    self.var_C7E7 playsoundtoteam("overcharge_fire_npc", "allies", self);
  }
}

func_ECCD() {
  wait(0.05);
  if(isDefined(self)) {
    playfxontagforclients(scripts\engine\utility::getfx("vfx_screen_flash"), self, "tag_eye", self);
    playFX(level.var_CAA3["spawn"], self.origin, anglesToForward(self.angles), anglestoup(self.angles));
  }
}

func_20CE() {
  self setclientomnvar("ui_overchargeOverlay", 1);
}

func_E12D() {
  self setclientomnvar("ui_overchargeOverlay", 0);
}