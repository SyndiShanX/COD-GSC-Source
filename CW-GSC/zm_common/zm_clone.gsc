/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: zm_common\zm_clone.gsc
***********************************************/

#using scripts\core_common\struct;
#using scripts\zm_common\zm_utility;
#using scripts\zm_common\zm_weapons;
#namespace zm_clone;

function spawn_player_clone(player, origin = player.origin, forceweapon, forcemodel) {
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

    clone function_1fac41e4(player function_19124308());
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

function clone_damage_func(einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, psoffsettime, boneindex) {
  psoffsettime = 0;

  if(boneindex.isballisticknife && zm_weapons::is_weapon_upgraded(boneindex)) {
    self notify(#"player_revived", {
      #reviver: shitloc
    });
  }

  return psoffsettime;
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
    return;
  }

  self thread clone_mover_animate(animtype);
}

function clone_actor_animate(animtype) {
  wait 0.1;

  switch (animtype) {
    case # "laststand":
      self setanimstatefromasd("laststand");
      break;
    case # "idle":
    default:
      self setanimstatefromasd("idle");
      break;
  }
}

function clone_mover_animate(animtype) {
  self useanimtree("generic");

  switch (animtype) {
    case # "laststand":
      self setanim(#"pb_laststand_idle");
      break;
    case # "afterlife":
      self setanim(#"pb_afterlife_laststand_idle");
      break;
    case # "chair":
      self setanim(#"ai_actor_elec_chair_idle");
      break;
    case # "falling":
      self setanim(#"pb_falling_loop");
      break;
    case # "idle":
    default:
      self setanim(#"pb_stand_alert");
      break;
  }
}