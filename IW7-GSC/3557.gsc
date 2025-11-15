/************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: 3557.gsc
************************/

func_5223() {
  level._effect["deployableCover_explode"] = loadfx("vfx\iw7\core\equipment\coverwall\vfx_coverwall_foam_expand_mp.vfx");
  level._effect["deployableCover_explode_mist"] = loadfx("vfx\iw7\core\equipment\coverwall\vfx_coverwall_mist_hang_mp.vfx");
}

func_5224(param_00) {
  param_00 endon("death");
  param_00 waittill("missile_stuck", var_01);
  self notify("powers_deployableCover_used", 1);
  param_00.angles = param_00.angles * (0, 1, 1);
  func_10842(param_00);
  param_00 delete();
}

func_10842(param_00) {
  var_01 = self.var_4759;
  if(isDefined(var_01)) {
    var_01 func_5285();
  }

  scripts\mp\utility::printgameaction("deployable cover spawned", param_00.triggerportableradarping);
  var_02 = anglesToForward(param_00.angles);
  var_02 = rotatepointaroundvector(anglestoup(param_00.angles), var_02, 90);
  var_03 = anglestoup(param_00.angles);
  var_04 = vectorcross(var_02, var_03);
  var_03 = vectorcross(var_04, var_02);
  var_05 = axistoangles(var_02, var_04, var_03);
  var_01 = spawncoverwall(param_00.origin + anglestoup(var_05) * 2, var_05);
  var_01.triggerportableradarping = self;
  var_01.team = self.team;
  var_01 setnonstick(1);
  var_01 give_player_tickets(1);
  var_01 setCanDamage(1);
  var_01.health = 9999;
  playFX(scripts\engine\utility::getfx("deployableCover_explode"), param_00.origin, anglesToForward(var_05), anglestoup(var_05));
  playFX(scripts\engine\utility::getfx("deployableCover_explode_mist"), param_00.origin, anglesToForward(var_05), anglestoup(var_05));
  playsoundatpos(param_00.origin, "deployable_cover_expand");
  var_01 thread func_40EB();
  var_01 thread func_40ED();
  var_01 thread func_40EC();
  var_01 thread func_40EE();
  var_01 thread func_139DE();
  var_01 thread func_139DF(self);
  var_01 thread scripts\mp\perks\_perk_equipmentping::runequipmentping();
  var_01 thread createcovernavobstacle();
  self.var_4759 = var_01;
}

createcovernavobstacle() {
  self endon("death");
  self endon("entitydeleted");
  self endon("despawnCover");
  self waittill("coverwall_expand_finish");
  self.var_BE64 = _func_314(self);
}

func_5285(param_00) {
  self notify("despawnCover");
  if(!isDefined(param_00)) {
    param_00 = 0;
  }

  if(!param_00) {
    playsoundatpos(self.origin, "deployable_cover_contract");
  }

  if(isDefined(self.var_BE64)) {
    destroynavobstacle(self.var_BE64);
    self.var_BE64 = undefined;
  }

  self _meth_8514(param_00);
  scripts\mp\utility::printgameaction("deployable cover removed", self.triggerportableradarping);
}

func_139DF(param_00) {
  self endon("death");
  param_00 endon("disconnect");
  self waittill("coverwall_expand_finish");
  wait(0.25);
  thread scripts\mp\weapons::outlineequipmentforowner(self, param_00);
  self waittill("coverwall_contract_start");
  self notify("death");
}

func_139DE() {
  self endon("death");
  self endon("despawnCover");
  for(;;) {
    self waittill("damage", var_00, var_01, var_02, var_03);
    self.health = 9999;
    var_01 scripts\mp\damagefeedback::updatedamagefeedback("hitequip");
  }
}

func_40EE() {
  self endon("death");
  self endon("despawnCover");
  wait(15);
  thread func_5285();
}

func_40EB() {
  self endon("death");
  self endon("despawnCover");
  self.triggerportableradarping waittill("death");
  thread func_5285();
}

func_40ED() {
  self endon("death");
  self endon("despawnCover");
  level scripts\engine\utility::waittill_any_3("game_ended", "bro_shot_start");
  thread func_5285();
}

func_40EC() {
  self endon("death");
  self endon("despawnCover");
  self.triggerportableradarping waittill("disconnect");
  thread func_5285(1);
}

placementfailed(param_00) {
  self notify("powers_deployableCover_used", 0);
  scripts\mp\utility::placeequipmentfailed(param_00.weapon_name, 1, param_00.origin);
  param_00 delete();
}