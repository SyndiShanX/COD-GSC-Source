/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: weapons\mp\trophy_system_spy.gsc
***********************************************/

#using scripts\core_common\battlechatter;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\contracts_shared;
#using scripts\core_common\player\player_stats;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\weapons\trophy_system;
#using scripts\weapons\weaponobjects;
#namespace trophy_system;

function private autoexec __init__system__() {
  system::register(#"trophy_system_spy", &preinit, undefined, undefined, undefined);
}

function private preinit() {
  level.trophydetonationfx = # "hash_7e2c1749cc5fcfb9";
  level.fx_trophy_radius_indicator = # "weapon/fx_trophy_radius_indicator";
  trophydeployanim = "p8_fxanim_mp_eqp_trophy_system_world_anim";
  trophyspinanim = "p8_fxanim_mp_eqp_trophy_system_world_open_anim";
  level.var_4f3822f4 = &trophysystemdetonate;
  clientfield::register("missile", "" + # "hash_65fa2e5290be670e", 1, 1, "int");
  clientfield::register("missile", "" + # "hash_19f94fb667823a5a", 1, 7, "float");
  callback::on_player_killed(&on_player_killed);
  callback::on_spawned(&ammo_reset);
  weaponobjects::function_e6400478("trophy_system_spy", &createtrophysystemwatcher, 1);
  callback::on_finalize_initialization(&function_1c601b99);
  function_720ddf7f(&function_ccfcde75);
}

function function_ccfcde75(trophy, grenade) {
  self battlechatter::function_fc82b10(trophy.weapon, grenade.origin, trophy);
  self contracts::increment_contract(#"hash_5d75f7e385889afa");

  if(isDefined(level.var_b7bc3c75.var_fbbc4c75)) {
    self[[level.var_b7bc3c75.var_fbbc4c75]](trophy);
  }
}

function createtrophysystemwatcher(watcher) {
  watcher.ondetonatecallback = &trophysystemdetonate;
  watcher.activatesound = # "wpn_claymore_alert";
  watcher.hackertoolradius = level.equipmenthackertoolradius;
  watcher.hackertooltimems = level.equipmenthackertooltimems;
  watcher.ownergetsassist = 1;
  watcher.ignoredirection = 1;
  watcher.activationdelay = 0.1;
  watcher.enemydestroy = 1;
  watcher.var_10efd558 = "switched_field_upgrade";
  watcher.onspawn = &ontrophysystemspawn;
  watcher.ondamage = &watchtrophysystemdamage;
  watcher.ondestroyed = &ontrophysystemsmashed;
  watcher.var_994b472b = &function_5a4f1e1e;
  watcher.onstun = &weaponobjects::weaponstun;
  watcher.stuntime = 1;
  watcher.ontimeout = &ontrophysystemsmashed;
}

function ontrophysystemspawn(watcher, player) {
  player endon(#"disconnect");
  level endon(#"game_ended");
  self endon(#"death");
  self useanimtree("generic");
  self weaponobjects::onspawnuseweaponobject(watcher, player);
  self.trophysystemstationary = 0;
  self.weapon = getweapon("trophy_system_spy");
  self.var_2d045452 = watcher;
  self.delete_on_death = 1;
  self.var_48d842c3 = 1;
  self.var_515d6dda = 1;
  self setweapon(self.weapon);
  self.ammo = player ammo_get(self.weapon);
  self.var_bf03cf85 = 0;
  self function_619a5c20();
  player stats::function_e24eec31(self.weapon, #"used", 1);
  player notify(#"hash_50994ef63f120738");
  self thread deployanim();
  self trophysystemstopped();

  if(self depthinwater() > 10) {
    function_3044fc5();
  }

  self thread trophyactive(player);
  self util::make_sentient();
}