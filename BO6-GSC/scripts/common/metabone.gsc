/***************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\common\metabone.gsc
***************************************/

#using scripts\common\callbacks;
#using scripts\common\devgui;
#using scripts\engine\math;
#namespace metabone;

function init_metabones(metabones_bundle_name) {
  assert(!isDefined(self.metabones), "<dev string:x24>");
  build_metabone_info(metabones_bundle_name);
  callback::add("on_ai_set_max_health", &function_8a959a3ac510c2d0);

  thread debug_metabones();
}

function restore_metabones(saved_metabones) {
  metabones_def = get_metabones_def(self.metabones.bundle_name);

  foreach(respawn_metabone in saved_metabones) {
    foreach(metabone_def in metabones_def.metabones) {
      var_fd04b8d568b6190d = getxhash(metabone_def.name);

      if(var_fd04b8d568b6190d == respawn_metabone.name) {
        metabone_name = metabone_def.name;
        break;
      }
    }

    metabone_info = self.metabones.info[metabone_name];
    metabone_info.is_active = respawn_metabone.is_active;
    metabone = metabones_def.var_2972332beaa5b174[metabone_name];

    foreach(state_name, state in metabone.var_63e19fb21594d5a2) {
      if(state.index == respawn_metabone.state_index) {
        set_metabone_state(metabone_name, state_name);

        if(self getscriptablehaspart(metabone_name) && self getscriptableparthasstate(metabone_name, state_name) && self getscriptablepartstate(metabone_name) != state_name) {
          self setscriptablepartstate(metabone_name, state_name, 1);
        }

        break;
      }
    }
  }
}

function is_metabone_destroyed(metabone_name) {
  if(!(isDefined(metabone_name) && isDefined(self.metabones))) {
    return 0;
  }

  metabones_def = get_metabones_def(self.metabones.bundle_name);
  metabone = metabones_def.var_2972332beaa5b174[metabone_name];

  if(isDefined(metabone)) {
    return is_destroyed(metabone);
  }

  return 0;
}

function function_ae1fbe819833ff94(metabone_name, data_type) {
  if(!(isDefined(metabone_name) && isDefined(self.metabones))) {
    return undefined;
  }

  metabones_def = get_metabones_def(self.metabones.bundle_name);
  metabone = metabones_def.var_2972332beaa5b174[metabone_name];

  if(isDefined(metabone)) {
    metadata = function_a4f4ee60be8ebe7b(metabone, data_type);

    if(isDefined(metadata)) {
      metadata_copy = structcopy(metadata, 1);
      return metadata_copy;
    }
  }

  return undefined;
}

function function_169ab69956ed127(metabone_name, active) {
  if(!(isDefined(self.metabones) && isDefined(metabone_name) && isDefined(self.metabones.info))) {
    return;
  }

  metabones_def = get_metabones_def(self.metabones.bundle_name);
  metabone = metabones_def.var_2972332beaa5b174[metabone_name];

  if(isDefined(metabone)) {
    self.metabones.info[metabone.name].is_active = active;

    if(active && isDefined(metabone.tags)) {
      foreach(tag in metabone.tags) {
        assert(isDefined(self gettagindex(tag.tagname)), "<dev string:x58>" + self getentitynumber() + "<dev string:x64>" + tag.tagname + "<dev string:x7f>" + metabone.name + "<dev string:x93>" + self.metabones.bundle_name + "<dev string:x9d>");
      }
    }

  }
}

function set_metabone_state(metabone_name, state_name) {
  if(!(isDefined(self.metabones) && isDefined(metabone_name) && isDefined(self.metabones.info))) {
    return undefined;
  }

  metabones_def = get_metabones_def(self.metabones.bundle_name);
  metabone = metabones_def.var_2972332beaa5b174[metabone_name];
  metabone_info = self.metabones.info[metabone.name];

  if(isDefined(metabone)) {
    if(isDefined(metabone_info.current_state_index)) {
      data = function_36ae1f4a9778c321(metabone.states[metabone_info.current_state_index], "Types_Damageable");

      if(isDefined(data)) {
        if(isDefined(metabone_info.health)) {
          metabone_info.var_9001c14ad8db7425[metabone_info.current_state_index] = metabone_info.health;
        }
      }
    }

    state = metabone.var_63e19fb21594d5a2[state_name];

    if(isDefined(state)) {
      metabone_info.current_state_index = state.index;

      if(isDefined(metabone_info.var_9001c14ad8db7425[metabone_info.current_state_index])) {
        metabone_info.health = metabone_info.var_9001c14ad8db7425[metabone_info.current_state_index];
      } else {
        metabone_info.health = undefined;
      }

      params = spawnStruct();
      params.metabone_name = metabone.name;
      params.state_name = state.name;
      callback::callback("metabone_state_changed", params);
    }
  }
}

function damage_metabone(metabone_name, damage, eattacker, einflictor, vdir) {
  if(!(isDefined(self.metabones) && isDefined(metabone_name) && isDefined(self.metabones.info))) {
    return 0;
  }

  b_destroyed = 0;
  metabone_info = self.metabones.info[metabone_name];

  if(metabone_info.health > 0) {
    if(damage < metabone_info.health) {
      metabone_info.health -= damage;
      params = spawnStruct();
      params.metabone_name = metabone_name;
      params.damage = damage;
      params.health = metabone_info.health;
      callback::callback("metabone_damaged_not_destroyed", params);
      self notify("metabone_damaged_not_destroyed");
    } else {
      destroy_metabone(metabone_name, eattacker, einflictor, vdir);
      self notify("metabone_destroyed");
      b_destroyed = 1;
    }
  }

  return b_destroyed;
}

function damage_metabone_state(metabone_name, damage, state_name, eattacker, einflictor) {
  assert(isDefined(state_name) && damage >= 0);
  new_health = function_c635b0dc08baefad(metabone_name, 1, -1 * damage, state_name);

  if(new_health <= 0) {
    destroy_metabone(metabone_name, eattacker, einflictor);
  }
}

function function_dbe4a2c3b0797294(metabone_name, health, state_name) {
  function_c635b0dc08baefad(metabone_name, 1, health, state_name);
}

function function_13685edc76d22c67(metabone_name, health, state_name) {
  function_c635b0dc08baefad(metabone_name, 0, health, state_name);
}

function function_50a0af5f47ae9a88(metabone_name) {
  metabones_def = get_metabones_def(self.metabones.bundle_name);
  metabone = metabones_def.var_2972332beaa5b174[metabone_name];
  function_452e9c3c677cfb85(metabone);
}

function function_906751e54d1bf5b3(metabone_name, state_name) {
  if(!(isDefined(self.metabones) && isDefined(metabone_name) && isDefined(self.metabones.info))) {
    return undefined;
  }

  metabone_info = self.metabones.info[metabone_name];

  if(!isDefined(metabone_info)) {
    assertmsg("<dev string:xb2>" + metabone_name);
    return undefined;
  }

  if(isDefined(state_name)) {
    metabones_def = get_metabones_def(self.metabones.bundle_name);
    target_metabone = metabones_def.var_2972332beaa5b174[metabone_name];
    target_state = target_metabone.var_63e19fb21594d5a2[state_name];
    target_state_index = target_state.index;

    if(target_state_index != metabone_info.current_state_index) {
      damageable_data = function_36ae1f4a9778c321(target_state, "Types_Damageable");

      if(!isDefined(damageable_data)) {
        return undefined;
      }

      assert(isDefined(metabone_info.var_9001c14ad8db7425[target_state_index]));
      return metabone_info.var_9001c14ad8db7425[target_state_index];
    }
  }

  if(isDefined(metabone_info.health)) {
    return metabone_info.health;
  }

  return undefined;
}

function function_7b81be2ff0d35c4f(metabone_name, state_name) {
  if(!(isDefined(self.metabones) && isDefined(metabone_name) && isDefined(self.metabones.info))) {
    return undefined;
  }

  metabone_info = self.metabones.info[metabone_name];

  if(!isDefined(metabone_info)) {
    assertmsg("<dev string:xb2>" + metabone_name);
    return undefined;
  }

  maxhealth = undefined;

  if(isDefined(state_name)) {
    metabones_def = get_metabones_def(self.metabones.bundle_name);
    target_metabone = metabones_def.var_2972332beaa5b174[metabone_name];
    target_state = target_metabone.var_63e19fb21594d5a2[state_name];
    damageable_data = function_36ae1f4a9778c321(target_state, "Types_Damageable");

    if(isDefined(damageable_data)) {
      if(!damageable_data.absolutehealth) {
        maxhealth = damageable_data.health * self.metabones.stored_maxhealth;
      } else {
        maxhealth = damageable_data.health;
      }
    }
  }

  return maxhealth;
}

function destroy_metabone(metabone_name, eattacker, einflictor, vdir) {
  if(!(isDefined(self.metabones) && isDefined(metabone_name) && isDefined(self.metabones.info))) {
    return undefined;
  }

  metabone_info = self.metabones.info[metabone_name];

  if(metabone_info.health > 0) {
    metabone_info.health = 0;
  }

  metabone_info.is_active = 0;

  if(isai(self)) {
    self._blackboard.var_3a0516652d1efb68 = metabone_name;
  }

  params = spawnStruct();
  params.metabone_name = metabone_name;
  params.eattacker = eattacker;
  params.einflictor = einflictor;
  params.vdir = vdir;
  callback::callback("metabone_destroyed", params);
}

function function_ddf2fd7b79c9d5b5(hit_loc, direction) {
  if(!(isDefined(self.metabones) && isDefined(self.metabones.info))) {
    return undefined;
  }

  metabones_def = get_metabones_def(self.metabones.bundle_name);

  foreach(metabone in metabones_def.metabones) {
    if(!self.metabones.info[metabone.name].is_active) {
      continue;
    }

    if(is_destroyed(metabone)) {
      continue;
    }

    if(!isDefined(metabone.hitlocations)) {
      continue;
    }

    foreach(metabone_hit_loc in metabone.hitlocations) {
      if(metabone_hit_loc.hitlocation == hit_loc) {
        if(isDefined(metabone_hit_loc.cosmaxangle) && isDefined(direction)) {
          root_forward = anglesToForward(self.angles);
          hit_dot = vectordot(root_forward, vectorNormalize(direction) * -1);

          if(hit_dot < metabone_hit_loc.cosmaxangle) {
            continue;
          }
        }

        return metabone.name;
      }
    }
  }

  return undefined;
}

function function_927e17286f4e0a54(part_name, direction) {
  if(!(isDefined(self.metabones) && isDefined(part_name) && isDefined(self.metabones.info))) {
    return undefined;
  }

  metabones_def = get_metabones_def(self.metabones.bundle_name);

  foreach(metabone in metabones_def.metabones) {
    if(!self.metabones.info[metabone.name].is_active) {
      continue;
    }

    if(is_destroyed(metabone)) {
      continue;
    }

    if(!(isDefined(metabone.parts) && isDefined(metabone.partmap))) {
      continue;
    }

    partindex = metabone.partmap[part_name];

    if(isDefined(partindex)) {
      metabone_part = metabone.parts[partindex];

      if(isDefined(metabone_part.cosmaxangle) && isDefined(direction)) {
        bone_forward = anglesToForward(self gettagangles(metabone_part.partname));
        hit_dot = vectordot(bone_forward, vectorNormalize(direction) * -1);

        if(hit_dot < metabone_part.cosmaxangle) {
          continue;
        }
      }

      return metabone.name;
    }
  }

  return undefined;
}

function function_2d9c443204521c97(point, direction) {
  if(!(isDefined(self.metabones) && isDefined(point) && isDefined(self.metabones.info))) {
    return undefined;
  }

  if(getdvarint(@ "hash_8ef2fd5f0121ed80", 0) > 0) {
    sphere(point, 5, (1, 0, 0));
    print3d(point, "<dev string:xe6>", (1, 0, 0), 0.5);
  }

  metabones_def = get_metabones_def(self.metabones.bundle_name);
  closest_metabone = undefined;
  closest_metabone_dist_sq = 0;

  foreach(metabone in metabones_def.metabones) {
    if(!self.metabones.info[metabone.name].is_active) {
      continue;
    }

    if(is_destroyed(metabone)) {
      continue;
    }

    if(!isDefined(metabone.tags)) {
      continue;
    }

    foreach(tag in metabone.tags) {
      tag_origin = self gettagorigin(tag.tagname);
      tag_radius_sq = squared(tag.radius ?? 1);
      dist_sq = distancesquared(point, tag_origin);

      if(dist_sq <= tag_radius_sq && (!isDefined(closest_metabone) || dist_sq < closest_metabone_dist_sq)) {
        if(isDefined(tag.cosmaxangle) && isDefined(direction)) {
          tag_forward = anglesToForward(self gettagangles(tag.tagname));
          tag_dot = vectordot(tag_forward, vectorNormalize(direction) * -1);

          if(tag_dot < tag.cosmaxangle) {
            continue;
          }
        }

        closest_metabone = metabone;
        closest_metabone_dist_sq = dist_sq;
      }
    }
  }

  if(isDefined(closest_metabone)) {
    return closest_metabone.name;
  }

  return undefined;
}

function get_metabone_name(hit_loc, part_name, point, direction) {
  if(!(isDefined(hit_loc) && isDefined(point)) || !(isDefined(self.metabones) && isDefined(self.metabones.info))) {
    return undefined;
  }

  metabones_def = get_metabones_def(self.metabones.bundle_name);

  foreach(metabone in metabones_def.metabones) {
    if(!self.metabones.info[metabone.name].is_active) {
      continue;
    }

    if(is_destroyed(metabone)) {
      continue;
    }

    if(isDefined(metabone.hitlocations)) {
      foreach(metabone_hit_loc in metabone.hitlocations) {
        if(metabone_hit_loc.hitlocation == hit_loc) {
          if(isDefined(metabone_hit_loc.cosmaxangle) && isDefined(direction)) {
            root_forward = anglesToForward(self.angles);
            hit_dot = vectordot(root_forward, vectorNormalize(direction) * -1);

            if(hit_dot < metabone_hit_loc.cosmaxangle) {
              continue;
            }
          }

          return metabone.name;
        }
      }
    }

    if(isDefined(metabone.parts) && isDefined(part_name) && isDefined(metabone.partmap)) {
      partindex = metabone.partmap[part_name];

      if(isDefined(partindex)) {
        metabone_part = metabone.parts[partindex];

        if(isDefined(metabone_part.cosmaxangle) && isDefined(direction)) {
          bone_forward = anglesToForward(self gettagangles(metabone_part.partname));
          hit_dot = vectordot(bone_forward, vectorNormalize(direction) * -1);

          if(hit_dot < metabone_part.cosmaxangle) {
            continue;
          }
        }

        return metabone.name;
      }
    }

    if(isDefined(metabone.tags)) {
      closest_metabone = undefined;
      closest_metabone_dist_sq = 99999999;

      foreach(tag in metabone.tags) {
        tag_origin = self gettagorigin(tag.tagname);
        dist_sq = distancesquared(point, tag_origin);

        if(!isDefined(closest_metabone) || dist_sq < closest_metabone_dist_sq) {
          tag_radius = tag.radius ?? 1;
          penetration_dist = tag.penetrationdist;

          if(isDefined(penetration_dist) && isDefined(direction)) {
            if(!math::segmentvssphere(point, point + direction * penetration_dist, tag_origin, tag_radius)) {
              continue;
            }
          } else if(dist_sq > squared(tag_radius)) {
            continue;
          }

          if(isDefined(tag.cosmaxangle) && isDefined(direction)) {
            tag_forward = anglesToForward(self gettagangles(tag.tagname));
            tag_dot = vectordot(tag_forward, vectorNormalize(direction) * -1);

            if(tag_dot < tag.cosmaxangle) {
              continue;
            }
          }

          closest_metabone = metabone;
          closest_metabone_dist_sq = dist_sq;
        }
      }

      if(isDefined(closest_metabone)) {
        return closest_metabone.name;
      }
    }
  }

  return undefined;
}

function function_cd947f1a3391c065(var_fb56e56d94279338, on_metabone_destroyed) {
  if(!isDefined(level.var_93f9a5daebf6b466)) {
    level.var_93f9a5daebf6b466 = [];
  }

  level.var_93f9a5daebf6b466[var_fb56e56d94279338] = on_metabone_destroyed;
}

function function_7b57cab1f2311c7b(var_fb56e56d94279338, on_metabone_damaged_not_destroyed) {
  if(!isDefined(level.var_9b860665f87348c8)) {
    level.var_9b860665f87348c8 = [];
  }

  level.var_9b860665f87348c8[var_fb56e56d94279338] = on_metabone_damaged_not_destroyed;
}

function function_b68bd9932f284448(var_682bceb3c14d0d51) {
  self.var_682bceb3c14d0d51 = var_682bceb3c14d0d51;
}

function function_b7f4a00525689bee(dmgstruct) {
  if(isDefined(self.var_682bceb3c14d0d51)) {
    return [[self.var_682bceb3c14d0d51]](dmgstruct);
  }
}

function function_83525a0b05843168() {
  return isDefined(self.var_682bceb3c14d0d51);
}

function function_23dfe92664fb40fd(var_af316a1ce17a9c8a) {
  self.var_af316a1ce17a9c8a = var_af316a1ce17a9c8a;
}

function function_d985a5fbf5939161(dmgstruct) {
  if(isDefined(self.var_af316a1ce17a9c8a)) {
    return [[self.var_af316a1ce17a9c8a]](dmgstruct);
  }
}

function function_3866ce438fcee825() {
  return isDefined(self.var_af316a1ce17a9c8a);
}

function function_8a959a3ac510c2d0(params) {
  metabones_def = get_metabones_def(self.metabones.bundle_name);

  foreach(metabone in metabones_def.metabones) {
    if(isDefined(metabone.states) && metabone.states.size > 0) {
      metabone_info = self.metabones.info[metabone.name];

      foreach(state_index, state in metabone.states) {
        damageable_data = function_36ae1f4a9778c321(state, "Types_Damageable");

        if(isDefined(damageable_data)) {
          if(!damageable_data.absolutehealth) {
            assert(isDefined(self.maxhealth), "<dev string:x58>" + self getentitynumber() + "<dev string:xf8>" + metabone.name + "<dev string:x93>" + self.metabones.bundle_name + "<dev string:x123>");
            var_9ff900e47a6acddc = damageable_data.health;

            if(isDefined(self.metabones.stored_maxhealth) && isDefined(metabone_info.health)) {
              var_9ff900e47a6acddc = damageable_data.health * self.metabones.stored_maxhealth;
            }

            if(state_index == metabone_info.current_state_index && isDefined(metabone_info.health)) {
              var_cf4e5bdc673857ce = metabone_info.health / var_9ff900e47a6acddc;
              metabone_info.health = damageable_data.health * self.maxhealth * var_cf4e5bdc673857ce;
              continue;
            }

            var_cf4e5bdc673857ce = metabone_info.var_9001c14ad8db7425[state_index] / var_9ff900e47a6acddc;
            metabone_info.var_9001c14ad8db7425[state_index] = damageable_data.health * self.maxhealth * var_cf4e5bdc673857ce;
          }
        }
      }
    }
  }
}

function function_30716bbed991d974(metabone_name) {
  if(!(isDefined(self.metabones) && isDefined(metabone_name) && isDefined(self.metabones.info))) {
    return false;
  }

  metabone_info = self.metabones.info[metabone_name];

  if(!(isDefined(metabone_info) && isDefined(metabone_info.current_state_index))) {
    return false;
  }

  metabones_def = get_metabones_def(self.metabones.bundle_name);
  metabone = metabones_def.var_2972332beaa5b174[metabone_name];
  state = metabone.states[metabone_info.current_state_index];
  armor_data = function_36ae1f4a9778c321(state, "Types_Armor");
  return isDefined(armor_data);
}

function function_81906360882441d4(metabone_name) {
  if(!(isDefined(self.metabones) && isDefined(metabone_name) && isDefined(self.metabones.info))) {
    return undefined;
  }

  metabone_info = self.metabones.info[metabone_name];

  if(!(isDefined(metabone_info) && isDefined(metabone_info.current_state_index))) {
    return undefined;
  }

  metabones_def = get_metabones_def(self.metabones.bundle_name);
  metabone = metabones_def.var_2972332beaa5b174[metabone_name];
  state = metabone.states[metabone_info.current_state_index];

  if(isDefined(state)) {
    return state.name;
  }
}

function function_30d906ccb9fe2142(data_type) {
  if(!(isDefined(self.metabones) && isDefined(self.metabones.info))) {
    return [];
  }

  active_metabones = [];
  metabones_def = get_metabones_def(self.metabones.bundle_name);

  foreach(metabone in metabones_def.metabones) {
    metabone_info = self.metabones.info[metabone.name];

    if(!metabone_info.is_active) {
      continue;
    }

    if(isDefined(data_type)) {
      metadata = function_a4f4ee60be8ebe7b(metabone, data_type);

      if(!isDefined(metadata)) {
        continue;
      }
    }

    active_metabones[active_metabones.size] = metabone.name;
  }

  return active_metabones;
}

function private function_c635b0dc08baefad(metabone_name, relative_add, health, state_name) {
  if(!(isDefined(self.metabones) && isDefined(metabone_name) && isDefined(self.metabones.info))) {
    return;
  }

  metabone_info = self.metabones.info[metabone_name];

  if(!isDefined(metabone_info)) {
    assertmsg("<dev string:x15b>" + metabone_name);
    return;
  }

  if(isDefined(state_name)) {
    metabones_def = get_metabones_def(self.metabones.bundle_name);
    target_metabone = metabones_def.var_2972332beaa5b174[metabone_name];
    target_state = target_metabone.var_63e19fb21594d5a2[state_name];
    target_state_index = target_state.index;

    if(target_state_index != metabone_info.current_state_index) {
      damageable_data = function_36ae1f4a9778c321(target_state, "<dev string:x18f>");
      assert(isDefined(damageable_data));
      assert(isDefined(metabone_info.var_9001c14ad8db7425[target_state_index]));

      if(relative_add) {
        metabone_info.var_9001c14ad8db7425[target_state_index] += health;
      } else {
        metabone_info.var_9001c14ad8db7425[target_state_index] = health;
      }

      return metabone_info.var_9001c14ad8db7425[target_state_index];
    }
  }

  if(isDefined(metabone_info.health)) {
    if(relative_add) {
      metabone_info.health += health;
    } else {
      metabone_info.health = health;
    }
  }

  return metabone_info.health;
}

function private is_destroyed(metabone) {
  if(!(isDefined(self.metabones) && isDefined(metabone) && isDefined(self.metabones.info))) {
    return false;
  }

  metabone_info = self.metabones.info[metabone.name];
  return metabone_info.health <= 0;
}

function private function_a4f4ee60be8ebe7b(metabone, data_type) {
  if(!(isDefined(self.metabones) && isDefined(metabone) && isDefined(self.metabones.info))) {
    return undefined;
  }

  metabone_info = self.metabones.info[metabone.name];

  if(isDefined(metabone_info.current_state_index)) {
    data = function_36ae1f4a9778c321(metabone.states[metabone_info.current_state_index], data_type);

    if(isDefined(data)) {
      return data;
    }
  }

  foreach(data in metabone.metadata) {
    if(data.variant_type == data_type) {
      return data.variant_object;
    }
  }

  return undefined;
}

function private function_36ae1f4a9778c321(metabone_state, data_type) {
  foreach(data in metabone_state.metadata) {
    if(data.variant_type == data_type) {
      return data.variant_object;
    }
  }

  return undefined;
}

function get_metabones_def(metabones_bundle_name) {
  metabones_def = undefined;

  if(isDefined(level.metabones_defs)) {
    metabones_def = level.metabones_defs[metabones_bundle_name];
  }

  if(!isDefined(metabones_def)) {
    metabones_def = load_metabones_def(metabones_bundle_name);
    level.metabones_defs[metabones_bundle_name] = metabones_def;
  }

  assert(isDefined(metabones_def));
  return metabones_def;
}

function private load_metabones_def(metabones_bundle_name) {
  metabones_def = getscriptbundle("metabonelist:" + metabones_bundle_name);
  metabones_def.var_2972332beaa5b174 = [];

  for(metabone_index = 0; metabone_index < metabones_def.metabones.size; metabone_index++) {
    metabone = metabones_def.metabones[metabone_index];

    if(!isDefined(metabone.name) || metabone.name == "") {
      metabone.name = string(metabone_index);
    }

    if(isDefined(metabones_def.var_2972332beaa5b174[metabone.name])) {
      assertmsg("<dev string:x1a3>" + metabones_bundle_name + "<dev string:x1af>" + metabone.name + "<dev string:x1d7>");
      metabone.name = string(metabone_index);
    }

    metabones_def.var_2972332beaa5b174[metabone.name] = metabone;
    metabone.var_63e19fb21594d5a2 = [];

    for(state_index = 0; state_index < metabone.states.size; state_index++) {
      state = metabone.states[state_index];
      state.index = state_index;

      if(isDefined(state.name) && state.name != "") {
        metabone.var_63e19fb21594d5a2[state.name] = state;
      }
    }
  }

  return metabones_def;
}

function private build_metabone_info(metabones_bundle_name) {
  self.metabones = spawnStruct();
  self.metabones.bundle_name = metabones_bundle_name;
  self.metabones.info = [];
  self.metabones.stored_maxhealth = self.maxhealth;
  metabones_def = get_metabones_def(self.metabones.bundle_name);

  foreach(metabone in metabones_def.metabones) {
    metabone_info = spawnStruct();
    self.metabones.info[metabone.name] = metabone_info;
    metabone_info.is_active = metabone.activebydefault ?? 0;

    if(isDefined(metabone.states) && metabone.states.size > 0) {
      metabone_info.current_state_index = 0;
    }

    function_452e9c3c677cfb85(metabone);

    if(isDefined(metabone.tags)) {
      foreach(tag in metabone.tags) {
        if(isDefined(tag.maxangle)) {
          tag.cosmaxangle = cos(tag.maxangle * 0.5);
        }
      }
    }

    if(isDefined(metabone.hitlocations)) {
      foreach(metabone_hit_loc in metabone.hitlocations) {
        if(isDefined(metabone_hit_loc.maxangle)) {
          metabone_hit_loc.cosmaxangle = cos(metabone_hit_loc.maxangle * 0.5);
        }
      }
    }

    if(isDefined(metabone.parts)) {
      if(metabone.parts.size > 0) {
        metabone.partmap = [];

        for(i = 0; i < metabone.parts.size; i++) {
          metabone_part = metabone.parts[i];
          metabone.partmap[metabone_part.partname] = i;

          if(isDefined(metabone_part.maxangle)) {
            metabone_part.cosmaxangle = cos(metabone_part.maxangle * 0.5);
          }
        }
      }
    }
  }

  if(isDefined(metabones_def.var_90ed8916f56ef56d) && isDefined(level.var_93f9a5daebf6b466) && isDefined(level.var_93f9a5daebf6b466[metabones_def.var_90ed8916f56ef56d])) {
    callback::add("metabone_destroyed", level.var_93f9a5daebf6b466[metabones_def.var_90ed8916f56ef56d]);
  }

  if(isDefined(metabones_def.var_90ed8916f56ef56d) && isDefined(level.var_9b860665f87348c8) && isDefined(level.var_9b860665f87348c8[metabones_def.var_90ed8916f56ef56d])) {
    callback::add("metabone_damaged_not_destroyed", level.var_9b860665f87348c8[metabones_def.var_90ed8916f56ef56d]);
  }

  validate_metabones();
}

function private function_452e9c3c677cfb85(metabone) {
  metabone_info = self.metabones.info[metabone.name];
  metabone_info.health = undefined;

  if(!isDefined(metabone_info.var_9001c14ad8db7425)) {
    metabone_info.var_9001c14ad8db7425 = [];

    foreach(state in metabone.var_63e19fb21594d5a2) {
      damageable_data = function_36ae1f4a9778c321(state, "Types_Damageable");

      if(isDefined(damageable_data)) {
        metabone_info.var_9001c14ad8db7425[state.index] = function_159026b8b70ff467(self, damageable_data);
      }
    }
  }

  if(isDefined(metabone_info.var_9001c14ad8db7425[metabone_info.current_state_index])) {
    metabone_info.health = metabone_info.var_9001c14ad8db7425[metabone_info.current_state_index];
    return;
  }

  var_26517a1aa9262796 = function_a4f4ee60be8ebe7b(metabone, "Types_Damageable");

  if(isDefined(var_26517a1aa9262796)) {
    assert(metabone_info.var_9001c14ad8db7425.size <= 0, "<dev string:x1dc>" + metabone.name);
    metabone_info.health = function_159026b8b70ff467(self, var_26517a1aa9262796);
  }
}

function private function_159026b8b70ff467(entity, damageable_data) {
  if(damageable_data.absolutehealth) {
    return damageable_data.health;
  }

  assert(isDefined(entity.maxhealth), "<dev string:x58>" + entity getentitynumber() + "<dev string:x224>" + entity.metabones.bundle_name + "<dev string:x123>");
  return damageable_data.health * entity.maxhealth;
}

function private validate_metabones() {
  metabones_def = get_metabones_def(self.metabones.bundle_name);

  foreach(metabone in metabones_def.metabones) {
    if(isDefined(metabone.tags) && self.metabones.info[metabone.name].is_active) {
      foreach(tag in metabone.tags) {
        assert(isDefined(self gettagindex(tag.tagname)), "<dev string:x58>" + self getentitynumber() + "<dev string:x64>" + tag.tagname + "<dev string:x7f>" + metabone.name + "<dev string:x93>" + self.metabones.bundle_name + "<dev string:x9d>");
      }
    }
  }
}

function private debug_metabones() {
  if(level.b_debug_metabones) {
    return;
  }

  level.b_debug_metabones = 1;
  level endon("<dev string:x245>");
  devgui::function_9082edeb5db93280("<dev string:x253>");
  devgui::function_eaac4ba4b3caf621("<dev string:x268>", @ "debug_metabones");
  devgui::function_502a7d5e4d9dfa5b("<dev string:x285>", "<dev string:x2a6>", &function_2d207b2301e14996);
  devgui::function_77df7fe7dd273e10();

  while(true) {
    if(getdvarint(@ "debug_metabones", 0) <= 0) {
      waitframe();
      continue;
    }

    entity_num = getdvarint(@ "debug_metabones_entnum", -1);
    entity = getentbynum(entity_num);

    if(!isalive(entity)) {
      entity_num = function_cf6713d9938a16d5();
      entity = getentbynum(entity_num);
    }

    if(isDefined(entity) && isDefined(entity.metabones)) {
      print_x = 400;
      print_y = 200;
      var_c0120496c3299fb1 = 30;
      printtoscreen2d(print_x, print_y, "<dev string:x2c8>");
      metabones_def = get_metabones_def(entity.metabones.bundle_name);

      foreach(metabone in metabones_def.metabones) {
        print_y += 40;
        metabone_info = entity.metabones.info[metabone.name];
        metabone_color = (1, 1, 1);
        var_a9485e6a874a730a = metabone.name;

        if(!metabone_info.is_active) {
          var_a9485e6a874a730a += "<dev string:x2d5>";
          metabone_color = (0.6, 0.6, 0.6);
        }

        if(entity is_destroyed(metabone)) {
          var_a9485e6a874a730a += "<dev string:x2e4>";
          metabone_color = (0.7, 0.7, 0.7);
        }

        printtoscreen2d(print_x, print_y, var_a9485e6a874a730a, metabone_color, 1);
        state_name = undefined;
        print_y += 18;

        if(isDefined(metabone_info.current_state_index)) {
          state = metabone.states[metabone_info.current_state_index];
          var_169020cf8ff43468 = "<dev string:x2f4>" + metabone_info.current_state_index;

          if(isDefined(state.name)) {
            state_name = state.name;
            var_169020cf8ff43468 = "<dev string:x2ff>" + state.name + "<dev string:x304>";
          }

          printtoscreen2d(print_x + var_c0120496c3299fb1, print_y, var_169020cf8ff43468, metabone_color);
        }

        print_y += 18;
        hurt_col = undefined;

        if(isDefined(metabone_info.health)) {
          max_health = entity function_7b81be2ff0d35c4f(metabone.name, state_name);
          health_percentage = "<dev string:x309>";

          if(isDefined(max_health)) {
            health_percentage = "<dev string:x30d>" + metabone_info.health / max_health * 100 + "<dev string:x313>";
          }

          health_col = metabone_color;

          if(isDefined(entity.last_dmg_struct.metabonename) && isDefined(state_name) && entity.last_dmg_struct.metabonename == metabone.name && gettime() - (entity.last_dmg_struct.timehit ?? 0) < 100) {
            hurt_col = (0.1, 1, 0.1);
            health_col = hurt_col;
          }

          printtoscreen2d(print_x + var_c0120496c3299fb1, print_y, "<dev string:x319>" + metabone_info.health + health_percentage, health_col);
        } else {
          printtoscreen2d(print_x + var_c0120496c3299fb1, print_y, "<dev string:x325>", metabone_color);
        }

        if(entity isscriptable()) {
          if(entity getscriptablehaspart(metabone.name)) {
            scriptable_state = entity getscriptablepartstate(metabone.name, 1);

            if(isDefined(scriptable_state)) {
              print_y += 18;
              printtoscreen2d(print_x + var_c0120496c3299fb1, print_y, "<dev string:x334>" + scriptable_state, metabone_color);
            }
          }
        }

        if(!entity is_destroyed(metabone)) {
          if(isDefined(metabone.tags)) {
            foreach(tag in metabone.tags) {
              tagorigin = entity gettagorigin(tag.tagname, 1);

              if(isDefined(tagorigin)) {
                tag_color = metabone_info.is_active ? (0.2, 0.2, 1) : hurt_col ?? (0.7, 0.1, 0.1);
                sphere(tagorigin, tag.radius, tag_color, 1);
                print3d(tagorigin, metabone.name, tag_color, 1, 0.25);
              }
            }
          }
        }
      }
    }

    waitframe();
  }
}

function private function_2d207b2301e14996(params) {
  setDvar(@ "debug_metabones_entnum", function_cf6713d9938a16d5());
}

function private function_cf6713d9938a16d5() {
  look_pos = devgui::function_97024c0a6d1256a6();

  if(isDefined(look_pos)) {
    nearby_ai = getaiarrayinradius(look_pos, 512);

    if(isDefined(nearby_ai)) {
      entity = function_47c86977a18df38b(nearby_ai, look_pos);

      if(isDefined(entity)) {
        return entity getentitynumber();
      }
    }
  }

  return -1;
}

# /