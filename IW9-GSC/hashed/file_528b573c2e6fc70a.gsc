/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_528b573c2e6fc70a.gsc
***********************************************/

_id_0AF4EB22319AD376(grenade) {
  grenade _id_4A6F3CE45560D2A4();
}

_id_4A6F3CE45560D2A4() {
  self endon("mine_triggered");
  self endon("mine_destroyed");
  self endon("death");
  owner = self.owner;
  team = self.owner.team;
  _id_541986F994DA2469 = isagent(owner);
  scripts\cp_mp\ent_manager::registerspawn(1, scripts\mp\equipment\claymore::sweepclaymore);
  scripts\mp\sentientpoolmanager::registersentient("Lethal_Static", owner, 1);
  owner scripts\mp\weapons::onequipmentplanted(self, "equip_claymore", scripts\mp\equipment\claymore::claymore_delete, 1);
  self missilethermal();
  self missileoutline();
  self setentityowner(owner);
  self setotherent(owner);
  self setnodeploy(1);
  thread scripts\mp\weapons::minedamagemonitor();
  thread scripts\mp\equipment\claymore::claymore_explodeonnotify();
  scripts\cp_mp\emp_debuff::set_apply_emp_callback(scripts\mp\equipment\claymore::claymore_empapplied);
  _id_736DEC95A49487A6::_id_172D848D58051FDF(scripts\mp\equipment\claymore::_id_4373872960A2D51A);
  scripts\mp\equipment\claymore::_id_49197CD063A740EA(scripts\mp\equipment\claymore::claymore_destroy);

  if(isDefined(level.elevators)) {
    foreach(elevators in level.elevators)
    elevators thread _id_5F903436642211AF::_id_5C07037726AE5001(self);
  }

  scripts\mp\equipment\claymore::claymore_updatedangerzone();
  self setscriptablepartstate("plant", "active", 0);
  owner setscriptablepartstate("equipClaymoreFXView", "plant", 0);
  thread scripts\mp\equipment\claymore::claymore_forceclampangles();
  wait 1;
  self setscriptablepartstate("arm", "active", 0);
  thread scripts\mp\equipment\claymore::claymore_watchfortrigger();
  thread scripts\mp\equipment_interact::remoteinteractsetup(scripts\mp\equipment\claymore::claymore_trigger, 1, 1);
}