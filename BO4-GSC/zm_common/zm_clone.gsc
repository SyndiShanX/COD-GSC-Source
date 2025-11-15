/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: zm_common\zm_clone.gsc
***********************************************/

#include scripts\core_common\struct;
#include scripts\zm_common\zm_utility;
#include scripts\zm_common\zm_weapons;

#namespace zm_clone;

spawn_player_clone(player, origin = player.origin, forceweapon, forcemodel) {
  primaryweapons = player getweaponslistprimaries();

  if(isDefined(forceweapon)) {
    weapon = forceweapon;
  } else if(primaryweapons.size) {
    weapon = primaryweapons[0];
  } else {
    weapon = player getcurrentweapon();
  }

  weaponmodel = weapon.worldmodel;
  spawner = getent("fake_player_spawner", "targetname");

  if(isDefined(spawner)) {
    clone = spawner spawnfromspawner();
    clone.origin = origin;
    clone.isactor = 1;
  } else {
    clone = spawn("script_model", origin);
    clone.isactor = 0;
  }

  if(isDefined(forcemodel)) {
    clone setModel(forcemodel);
  } else {
    if(player function_390cb543()) {
      var_1749f1e8 = player function_92ea4100();

      if(isDefined(var_1749f1e8)) {
        clone setModel(var_1749f1e8);
      }

      headmodel = player startquantity();

      if(isDefined(headmodel)) {
        if(isDefined(clone.head)) {
          clone detach(clone.head);
        }

        clone attach(headmodel);
      }

      if(isDefined(clone.legs)) {
        clone detach(clone.legs);
      }

      if(isDefined(clone.torso)) {
        clone detach(clone.torso);
      }
    } else {
      var_41206ae3 = player function_5d23af5b();

      if(isDefined(var_41206ae3)) {
        clone setModel(var_41206ae3);
      }

      headmodel = player startquantity();

      if(isDefined(headmodel)) {
        if(isDefined(clone.head)) {
          clone detach(clone.head);
        }

        clone attach(headmodel);
      }

      var_b4d88433 = player function_cde23658();

      if(isDefined(var_b4d88433)) {
        if(isDefined(clone.legs)) {
          clone detach(clone.legs);
        }

        clone attach(var_b4d88433);
      }

      var_1749f1e8 = player function_92ea4100();

      if(isDefined(var_1749f1e8)) {
        if(isDefined(clone.torso)) {
          clone detach(clone.torso);
        }

        clone attach(var_1749f1e8);
      }
    }

    clone setbodyrenderoptionspacked(player getcharacterbodyrenderoptions());
  }

  if(weaponmodel != "" && weaponmodel != "none") {
    clone attach(weaponmodel, "tag_weapon_right");
  }

  clone.team = player.team;
  clone.is_inert = 1;
  clone.zombie_move_speed = "walk";
  clone.script_noteworthy = "corpse_clone";
  clone.actor_damage_func = &clone_damage_func;
  return clone;
}

clone_damage_func(einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, psoffsettime, boneindex) {
  idamage = 0;

  if(weapon.isballisticknife && zm_weapons::is_weapon_upgraded(weapon)) {
    self notify(#"player_revived", {
      #reviver: eattacker
    });
  }

  return idamage;
}

clone_give_weapon(weapon) {
  weaponmodel = weapon.worldmodel;

  if(weaponmodel != "" && weaponmodel != "none") {
    self attach(weaponmodel, "tag_weapon_right");
  }
}

clone_animate(animtype) {
  if(self.isactor) {
    self thread clone_actor_animate(animtype);
    return;
  }

  self thread clone_mover_animate(animtype);
}

clone_actor_animate(animtype) {
  wait 0.1;

  switch (animtype) {
    case #"laststand":
      self setanimstatefromasd("laststand");
      break;
    case #"idle":
    default:
      self setanimstatefromasd("idle");
      break;
  }
}

clone_mover_animate(animtype) {
  self useanimtree("generic");

  switch (animtype) {
    case #"laststand":
      self setanim(#"pb_laststand_idle");
      break;
    case #"afterlife":
      self setanim(#"pb_afterlife_laststand_idle");
      break;
    case #"chair":
      self setanim(#"ai_actor_elec_chair_idle");
      break;
    case #"falling":
      self setanim(#"pb_falling_loop");
      break;
    case #"idle":
    default:
      self setanim(#"pb_stand_alert");
      break;
  }
}