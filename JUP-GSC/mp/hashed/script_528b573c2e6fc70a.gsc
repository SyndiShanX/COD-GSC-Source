/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_528b573c2e6fc70a.gsc
*************************************************/

#using scripts\common\elevators;
#using scripts\common\utility;
#using scripts\cp_mp\damagefeedback;
#using scripts\cp_mp\emp_debuff;
#using scripts\cp_mp\ent_manager;
#using scripts\cp_mp\equipment\haywire;
#using scripts\engine\trace;
#using scripts\engine\utility;
#using scripts\mp\equipment\claymore;
#using scripts\mp\equipment_interact;
#using scripts\mp\sentientpoolmanager;
#using scripts\mp\utility\equipment;
#using scripts\mp\utility\perk;
#using scripts\mp\utility\player;
#using scripts\mp\utility\print;
#using scripts\mp\utility\script;
#using scripts\mp\weapons;
#namespace agent_claymore;

function function_af4eb22319ad376(grenade) {
  grenade function_4a6f3ce45560d2a4();
}

function function_4a6f3ce45560d2a4() {
  self endon("mine_triggered");
  self endon("mine_destroyed");
  self endon("death");
  owner = self.owner;
  team = self.owner.team;
  var_541986f994da2469 = isagent(owner);
  ent_manager::registerspawn(1, &claymore::sweepclaymore);
  sentientpoolmanager::registersentient("Lethal_Static", owner, 1);
  owner onequipmentplanted(self, "equip_claymore", &claymore::claymore_delete, 1);
  self missilethermal();
  self missileoutline();
  self setentityowner(owner);
  self setotherent(owner);
  self setnodeploy(1);
  thread weapons::minedamagemonitor();
  thread claymore::claymore_explodeonnotify();
  emp_debuff::set_apply_emp_callback(&claymore::claymore_empapplied);
  haywire::function_172d848d58051fdf(&claymore::function_4373872960a2d51a);
  claymore::function_49197cd063a740ea(&claymore::claymore_destroy);

  if(isDefined(level.elevators)) {
    foreach(elevators in level.elevators) {
      elevators thread elevators::isentitytouchingdoortrigger(self);
    }
  }

  claymore::claymore_updatedangerzone();
  self setscriptablepartstate("plant", "active", 0);
  owner setscriptablepartstate("equipClaymoreFXView", "plant", 0);
  thread claymore::claymore_forceclampangles();
  wait 1;
  self setscriptablepartstate("arm", "active", 0);
  thread claymore::claymore_watchfortrigger();
  thread equipment_interact::remoteinteractsetup(&claymore::claymore_trigger, 1, 1);
}