/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_7b3f9a96ee8adefa.gsc
*************************************************/

#using script_16ea1b94f0f381b3;
#using scripts\common\devgui;
#using scripts\common\powerups;
#using scripts\cp_mp\powerups\powerups;
#using scripts\engine\utility;
#using scripts\mp\gametypes\br_weapons;
#namespace namespace_2a464bfce46d86a5;

function autoexec main() {
  if(getdvarint(@ "hash_5f4c8ff726eb8e87", 0) && !getdvarint(@ "hash_39efbbcf50eaa5", 0)) {
    init();
  }
}

function init() {
  utility::registersharedfunc("powerup_full_ammo", "should_drop", &should_drop);
  utility::registersharedfunc("powerup_full_ammo", "modify_drop_chance", &modify_drop_chance);
  utility::registersharedfunc("powerup_full_ammo", "give_ammo", &give_ammo);
}

function should_drop() {
  return true;
}

function modify_drop_chance(chance, context) {
  player = context.player;
  weapons = player getweaponslistprimaries();

  if(weapons.size <= 0) {
    return 0;
  }

  sum = 0;
  count = 0;

  foreach(weap in weapons) {
    ammotype = br_ammo_type_for_weapon(weap);

    if(isDefined(ammotype) && isDefined(level.var_e6ea72fc5e3fcd00[ammotype])) {
      var_2da18d7f86d1a3de = utility::get_int_or_0(player.br_ammo[ammotype]) / level.var_e6ea72fc5e3fcd00[ammotype];
      sum += var_2da18d7f86d1a3de;
      count++;
    }
  }

  if(count == 0) {
    return 0;
  }

  var_1d9804a7533b4fe0 = sum / count;

  if(var_1d9804a7533b4fe0 >= 1) {
    return (chance * 0.25);
  }

  if(var_1d9804a7533b4fe0 > 0.3) {
    return chance;
  }

  return chance * 2;
}

function give_ammo() {
  br_weapons::br_ammo_player_max_out();
}