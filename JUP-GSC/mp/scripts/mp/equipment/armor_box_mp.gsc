/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\equipment\armor_box_mp.gsc
*************************************************/

#using scripts\common\ae_utility;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\cp_mp\damagefeedback;
#using scripts\engine\utility;
#using scripts\mp\equipment;
#using scripts\mp\equipment\support_box;
#using scripts\mp\weapons;
#namespace armor_box_mp;

function autoexec main() {
  registersharedfunc("armor_drop", "init", &init);
}

function init() {
  level.onarmorboxusedbyplayer = &onarmorboxusedbyplayer;
}

function onarmorboxusedbyplayer(player) {
  armoramount = getdvarint(@ "hash_796878180a8e250", 4);

  if(isDefined(player.equipment) && !isDefined(player.equipment["health"])) {
    player.equipment["health"] = "equip_armorplate";
  }

  player scripts\mp\equipment::incrementequipmentslotammo("health", armoramount);
  player hudicontype("br_armor");
  scripts\mp\equipment\support_box::supportbox_playusesound(player);
  thread scripts\mp\equipment\support_box::supportbox_onplayeruseanim();
  return true;
}