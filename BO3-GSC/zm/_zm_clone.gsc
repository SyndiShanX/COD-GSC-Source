/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: zm\_zm_clone.gsc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\zm\_zm_utility;
#using scripts\zm\_zm_weapons;
#using_animtree("zm_ally");
#namespace zm_clone;

function spawn_player_clone(player, origin = player.origin, forceweapon, forcemodel) {
  primaryweapons = player getweaponslistprimaries();
  if(isdefined(forceweapon)) {
    weapon = forceweapon;
  } else {
    if(primaryweapons.size) {
      weapon = primaryweapons[0];
    } else {
      weapon = player getcurrentweapon();
    }
  }
  weaponmodel = weapon.worldmodel;
  spawner = getent("fake_player_spawner", "targetname");
  if(isdefined(spawner)) {
    clone = spawner spawnfromspawner();
    clone.origin = origin;
    clone.isactor = 1;
  } else {
    clone = spawn("script_model", origin);
    clone.isactor = 0;
  }
  if(isdefined(forcemodel)) {
    clone setmodel(forcemodel);
  } else {
    mdl_body = player getcharacterbodymodel();
    clone setmodel(mdl_body);
    bodyrenderoptions = player getcharacterbodyrenderoptions();
    clone setbodyrenderoptions(bodyrenderoptions, bodyrenderoptions, bodyrenderoptions);
  }
  if(weaponmodel != "" && weaponmodel != "none") {
    clone attach(weaponmodel, "tag_weapon_right");
  }
  clone.team = player.team;
  clone.is_inert = 1;
  clone.zombie_move_speed = "walk";
  clone.script_noteworthy = "corpse_clone";
  clone.actor_damage_func = & clone_damage_func;
  return clone;
}

function clone_damage_func(einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, psoffsettime, boneindex) {
  idamage = 0;
  if(weapon.isballisticknife && zm_weapons::is_weapon_upgraded(weapon)) {
    self notify("player_revived", eattacker);
  }
  return idamage;
}

function clone_give_weapon(weapon) {
  weaponmodel = weapon.worldmodel;
  if(weaponmodel != "" && weaponmodel != "none") {
    self attach(weaponmodel, "tag_weapon_right");
  }
}

function clone_animate(animtype) {
  if(self.isactor) {
    self thread clone_actor_animate(animtype);
  } else {
    self thread clone_mover_animate(animtype);
  }
}

function clone_actor_animate(animtype) {
  wait(0.1);
  switch (animtype) {
    case "laststand": {
      self setanimstatefromasd("laststand");
      break;
    }
    case "idle":
    default: {
      self setanimstatefromasd("idle");
      break;
    }
  }
}

function clone_mover_animate(animtype) {
  self useanimtree($zm_ally);
  switch (animtype) {
    case "laststand": {
      self setanim( % zm_ally::pb_laststand_idle);
      break;
    }
    case "afterlife": {
      self setanim( % zm_ally::pb_afterlife_laststand_idle);
      break;
    }
    case "chair": {
      self setanim( % zm_ally::ai_actor_elec_chair_idle);
      break;
    }
    case "falling": {
      self setanim( % zm_ally::pb_falling_loop);
      break;
    }
    case "idle":
    default: {
      self setanim( % zm_ally::pb_stand_alert);
      break;
    }
  }
}