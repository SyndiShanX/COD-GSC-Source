/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp_common\callbacks.gsc
***********************************************/

#include scripts\core_common\bots\bot;
#include scripts\core_common\bots\bot_traversals;
#include scripts\core_common\callbacks_shared;
#include scripts\core_common\globallogic\globallogic_vehicle;
#include scripts\core_common\system_shared;
#include scripts\mp_common\gametypes\globallogic;
#include scripts\mp_common\gametypes\globallogic_actor;
#include scripts\mp_common\gametypes\globallogic_scriptmover;
#include scripts\mp_common\gametypes\hostmigration;
#include scripts\mp_common\player\player_callbacks;
#include scripts\mp_common\player\player_connect;
#include scripts\mp_common\player\player_damage;
#include scripts\mp_common\player\player_disconnect;
#include scripts\mp_common\player\player_killed;
#include scripts\weapons\deployable;

#namespace callback;

autoexec __init__system__() {
  system::register(#"callback", &__init__, undefined, undefined);
}

__init__() {
  set_default_callbacks();
}

on_prematch_end(func, obj) {
  if(self == level) {
    add_callback(#"prematch_end", func, obj);
    return;
  }

  function_d8abfc3d(#"prematch_end", func, obj);
}

on_changed_specialist(func, obj) {
  add_callback(#"changed_specialist", func, obj);
}

set_default_callbacks() {
  level.callbackstartgametype = &globallogic::callback_startgametype;
  level.callbackplayerconnect = &player::callback_playerconnect;
  level.callbackplayerdisconnect = &player::callback_playerdisconnect;
  level.callbackplayerdamage = &player::callback_playerdamage;
  level.callbackplayerkilled = &player::callback_playerkilled;
  level.var_3a9881cb = &player::function_74b6d714;
  level.callbackplayershielddamageblocked = &player::callback_playershielddamageblocked;
  level.callbackplayermelee = &player::callback_playermelee;
  level.callbackplayerlaststand = &player::callback_playerlaststand;
  level.callbackactorspawned = &globallogic_actor::callback_actorspawned;
  level.callbackactordamage = &globallogic_actor::callback_actordamage;
  level.callbackactorkilled = &globallogic_actor::callback_actorkilled;
  level.callbackactorcloned = &globallogic_actor::callback_actorcloned;
  level.var_6788bf11 = &globallogic_scriptmover::function_8c7ec52f;
  level.callbackvehiclespawned = &globallogic_vehicle::callback_vehiclespawned;
  level.callbackvehicledamage = &globallogic_vehicle::callback_vehicledamage;
  level.callbackvehiclekilled = &globallogic_vehicle::callback_vehiclekilled;
  level.callbackvehicleradiusdamage = &globallogic_vehicle::callback_vehicleradiusdamage;
  level.callbackplayermigrated = &player::callback_playermigrated;
  level.callbackhostmigration = &hostmigration::callback_hostmigration;
  level.callbackhostmigrationsave = &hostmigration::callback_hostmigrationsave;
  level.callbackprehostmigrationsave = &hostmigration::callback_prehostmigrationsave;
  level.callbackbotentereduseredge = &bot::callback_botentereduseredge;
  level.callbackbotcreateplayerbot = &bot::function_c6e29bdf;
  level.callbackbotshutdown = &bot::function_3d575aa3;
  level.var_69959686 = &deployable::function_209fda28;
  level.var_bb1ea3f1 = &deployable::function_84fa8d39;
  level.var_2f64d35 = &deployable::function_cf538621;
  level.var_a28be0a5 = &globallogic::function_991daa12;
  level.var_bd0b5fc1 = &globallogic::function_ec7cf015;
  level._custom_weapon_damage_func = &callback_weapon_damage;
  level._gametype_default = "tdm";
}