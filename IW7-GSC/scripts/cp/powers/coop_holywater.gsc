/************************************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: scripts\cp\powers\coop_holywater.gsc
************************************************/

init() {
  level._effect["holyWater_ring_idle"] = loadfx("vfx\iw7\levels\cp_disco\vfx_holywater_ring_idle");
  level._effect["holyWater_explode"] = loadfx("vfx\core\expl\grenade_flash");
  scripts\engine\utility::flag_init("power_holyWater_enabled");
  scripts\engine\utility::flag_init("flag_player_holding_holyWater");
  level.powers["power_holyWater"].var_AD4E = [];
}

giveholywater() {
  self.holywater = spawnStruct();
  self.holywater.hold_time = 0;
  thread holywater_projectile_watcher();
  scripts\engine\utility::flag_set("power_holyWater_enabled");
}

takeholywater() {
  level notify("cleanup_holyWater_weapon");
  scripts\engine\utility::flag_clear("power_holyWater_enabled");
  self.holywater = undefined;
}

holywater_projectile_watcher() {
  level endon("cleanup_holyWater_weapon");
  for(;;) {
    self waittill("grenade_fire", var_0);
    if(!isDefined(var_0.weapon_name)) {
      continue;
    }

    if(var_0.weapon_name != "holywater_cp") {
      continue;
    }

    scripts\engine\utility::flag_clear("flag_player_holding_holyWater");
    level notify("holyWater_thrown");
    var_0.triggerportableradarping = self;
    var_0 thread holywater_projectile_instance();
  }
}

holywater_projectile_instance() {
  self endon("death");
  level.powers["power_holyWater"].var_AD4E = scripts\engine\utility::array_add(level.powers["power_holyWater"].var_AD4E, self);
  var_0 = gettime();
  level.zbg_active = 1;
  self waittill("missile_stuck");
  self hide();
  var_1 = 10 - gettime() - var_0 / 1000;
  var_2 = undefined;
  if(var_1 > 0) {
    level notify("holyWater_landed", self);
    var_2 = spawn("script_model", self.origin);
    var_2 setModel("cp_holywater_trap");
    var_2 linkto(self);
    wait(1);
    var_2 setscriptablepartstate("fx", "start");
    var_2 thread create_aod(var_0);
    wait(var_1);
  }

  self notify("aod_removed");
  level.powers["power_holyWater"].var_AD4E = scripts\engine\utility::array_remove(level.powers["power_holyWater"].var_AD4E, self);
  if(isDefined(var_2)) {
    var_2 delete();
  }

  level.zbg_active = undefined;
  self delete();
}

create_aod(var_0) {
  var_1 = scripts\cp\cp_agent_utils::getaliveagentsofteam("axis");
  var_2 = scripts\engine\utility::get_array_of_closest(self.origin, var_1, undefined, undefined, 64, 0);
  foreach(var_4 in var_2) {
    var_4.dontmutilate = 1;
    var_4 dodamage(var_4.health + 100, self.origin, self, self, "MOD_UNKNOWN", "iw7_electrictrap_zm");
  }

  var_6 = createnavobstaclebybounds(self.origin, (72, 72, 12), (0, 0, 0), "axis");
  while(isDefined(self)) {
    wait(0.05);
  }

  destroynavobstacle(var_6);
}