/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: 3557.gsc
*********************************************/

func_5223() {
  level._effect["deployableCover_explode"] = loadfx("vfx\iw7\core\equipment\coverwall\vfx_coverwall_foam_expand_mp.vfx");
  level._effect["deployableCover_explode_mist"] = loadfx("vfx\iw7\core\equipment\coverwall\vfx_coverwall_mist_hang_mp.vfx");
}

func_5224(var_0) {
  var_0 endon("death");
  var_0 waittill("missile_stuck", var_1);
  self notify("powers_deployableCover_used", 1);
  var_0.angles = var_0.angles * (0, 1, 1);
  func_10842(var_0);
  var_0 delete();
}

func_10842(var_0) {
  var_1 = self.var_4759;
  if(isDefined(var_1)) {
    var_1 func_5285();
  }

  scripts\mp\utility::printgameaction("deployable cover spawned", var_0.triggerportableradarping);
  var_2 = anglesToForward(var_0.angles);
  var_2 = rotatepointaroundvector(anglestoup(var_0.angles), var_2, 90);
  var_3 = anglestoup(var_0.angles);
  var_4 = vectorcross(var_2, var_3);
  var_3 = vectorcross(var_4, var_2);
  var_5 = axistoangles(var_2, var_4, var_3);
  var_1 = spawncoverwall(var_0.origin + anglestoup(var_5) * 2, var_5);
  var_1.triggerportableradarping = self;
  var_1.team = self.team;
  var_1 setnonstick(1);
  var_1 give_player_tickets(1);
  var_1 setCanDamage(1);
  var_1.health = 9999;
  playFX(scripts\engine\utility::getfx("deployableCover_explode"), var_0.origin, anglesToForward(var_5), anglestoup(var_5));
  playFX(scripts\engine\utility::getfx("deployableCover_explode_mist"), var_0.origin, anglesToForward(var_5), anglestoup(var_5));
  playsoundatpos(var_0.origin, "deployable_cover_expand");
  var_1 thread func_40EB();
  var_1 thread func_40ED();
  var_1 thread func_40EC();
  var_1 thread func_40EE();
  var_1 thread func_139DE();
  var_1 thread func_139DF(self);
  var_1 thread scripts\mp\perks\_perk_equipmentping::runequipmentping();
  var_1 thread createcovernavobstacle();
  self.var_4759 = var_1;
}

createcovernavobstacle() {
  self endon("death");
  self endon("entitydeleted");
  self endon("despawnCover");
  self waittill("coverwall_expand_finish");
  self.var_BE64 = _func_314(self);
}

func_5285(var_0) {
  self notify("despawnCover");
  if(!isDefined(var_0)) {
    var_0 = 0;
  }

  if(!var_0) {
    playsoundatpos(self.origin, "deployable_cover_contract");
  }

  if(isDefined(self.var_BE64)) {
    destroynavobstacle(self.var_BE64);
    self.var_BE64 = undefined;
  }

  self func_8514(var_0);
  scripts\mp\utility::printgameaction("deployable cover removed", self.triggerportableradarping);
}

func_139DF(var_0) {
  self endon("death");
  var_0 endon("disconnect");
  self waittill("coverwall_expand_finish");
  wait(0.25);
  thread scripts\mp\weapons::outlineequipmentforowner(self, var_0);
  self waittill("coverwall_contract_start");
  self notify("death");
}

func_139DE() {
  self endon("death");
  self endon("despawnCover");
  for(;;) {
    self waittill("damage", var_0, var_1, var_2, var_3);
    self.health = 9999;
    var_1 scripts\mp\damagefeedback::updatedamagefeedback("hitequip");
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

placementfailed(var_0) {
  self notify("powers_deployableCover_used", 0);
  scripts\mp\utility::placeequipmentfailed(var_0.weapon_name, 1, var_0.origin);
  var_0 delete();
}