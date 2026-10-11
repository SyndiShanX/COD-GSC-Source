/********************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\scripts\cp_mp\vehicles\vehicle_damage.gsc
********************************************************/

#using scripts\common\callbacks;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\cp_mp\damagefeedback;
#using scripts\cp_mp\pet_watch;
#using scripts\cp_mp\utility\damage_utility;
#using scripts\cp_mp\utility\game_utility;
#using scripts\cp_mp\utility\vehicle_omnvar_utility;
#using scripts\cp_mp\utility\weapon_utility;
#using scripts\cp_mp\vehicles\vehicle;
#using scripts\cp_mp\vehicles\vehicle_damage;
#using scripts\cp_mp\vehicles\vehicle_occupancy;
#using scripts\cp_mp\vehicles\vehicle_spawn;
#using scripts\cp_mp\vehicles\vehicle_tracking;
#using scripts\engine\math;
#using scripts\engine\scriptable;
#using scripts\engine\utility;
#namespace vehicle_damage;

function vehicle_damage_setCanDamage(bool) {
  linkedents = self getlinkedchildren(1);

  if(isDefined(linkedents)) {
    foreach(linkedent in linkedents) {
      if(isDefined(linkedent.code_classname) && linkedent.code_classname == "misc_turret") {
        if(bool) {
          linkedent thread vehicle_damage_keepturretalive(self);
          continue;
        }

        linkedent vehicle_damage_keepturretaliveend();
      }
    }
  }

  self setCanDamage(bool);
  vehicle_damage_cleareventlog(self);
}

function vehicle_damage_getleveldataforvehicle(vehicleref, create, var_6ecb77fd1f27c667) {
  if(istrue(create) && (!function_89dc39dc11f3988c(vehicleref) || !isDefined(function_29b4292c92443328(vehicleref).damage) || !isDefined(function_29b4292c92443328(vehicleref).damage.class))) {
    data = undefined;

    if(!function_89dc39dc11f3988c(vehicleref)) {
      data = spawnStruct();
    } else {
      data = function_29b4292c92443328(vehicleref);
    }

    if(!isDefined(data.damage)) {
      data.damage = spawnStruct();
    }

    data.damage.damagestatedata = [];
    data.damage.class = "none";
    data.damage.visualpercents = [];
    data.damage.visualcallbacks = [];
    data.damage.visualclearcallbacks = [];
    level.var_a0b2c978ca57ffc5[vehicleref] = data;
  }

  if(function_89dc39dc11f3988c(vehicleref)) {
    return function_29b4292c92443328(vehicleref).damage;
  }
}

function vehicle_damage_getinstancedataforvehicle(vehicle, create, var_6ecb77fd1f27c667) {
  instancedataforvehicle = vehicle.damagedata;

  if(!isDefined(instancedataforvehicle)) {
    if(istrue(create)) {
      instancedataforvehicle = spawnStruct();
      vehicle.damagedata = instancedataforvehicle;
      instancedataforvehicle.destroyscoreevent = undefined;
      instancedataforvehicle.destroyscorelaunchonly = undefined;
      instancedataforvehicle.destroyaward = undefined;
      instancedataforvehicle.destroyawardlaunchonly = undefined;
      instancedataforvehicle.heavydamagescoreevent = undefined;
      instancedataforvehicle.heavydamagescorelaunchonly = undefined;
      instancedataforvehicle.heavydamageaward = undefined;
      instancedataforvehicle.heavydamageawardlaunchonly = undefined;
    } else if(!istrue(var_6ecb77fd1f27c667)) {
      assertmsg("vehicle_damage_getInstanceDataForVehicle called on a vehicle without damage instance data.");
    }
  }

  return instancedataforvehicle;
}

function vehicle_damage_deregisterinstance(vehicle) {
  vehicle.damagedata = undefined;
}

function vehicle_damage_getleveldatafordamagestate(vehicleref, stateref, create, var_6ecb77fd1f27c667) {
  leveldataforvehicle = vehicle_damage_getleveldataforvehicle(vehicleref, create, var_6ecb77fd1f27c667);
  leveldatafordamagestate = leveldataforvehicle.damagestatedata[stateref];

  if(!isDefined(leveldatafordamagestate)) {
    if(istrue(create)) {
      leveldatafordamagestate = spawnStruct();
      leveldataforvehicle.damagestatedata[stateref] = leveldatafordamagestate;
      leveldatafordamagestate.maxhealth = undefined;
      leveldatafordamagestate.onentercallback = undefined;
      leveldatafordamagestate.onexitcallback = undefined;
    } else if(!istrue(var_6ecb77fd1f27c667)) {
      assertmsg("vehicle_damage_getLevelDataForDamageState called with an invalid stateRef.");
    }
  }

  return leveldatafordamagestate;
}

function vehicle_damage_clearvisuals(data, changed, fromdeath) {
  leveldataforvehicle = vehicle_damage_getleveldataforvehicle(function_d93ec4635290febd(), 0, 1);

  if(isDefined(leveldataforvehicle)) {
    foreach(callback in leveldataforvehicle.visualclearcallbacks) {
      self thread[[callback]](data, changed, fromdeath);
    }
  }
}

function function_b0662e99fcc0b8e0() {
  function_653b96ce8310763e(self.maxhealth);
}

function function_653b96ce8310763e(var_ca12ff65fd9d113e) {
  self.health = int(min(self.health + var_ca12ff65fd9d113e, self.maxhealth));
  leveldataforvehicle = vehicle_damage_getleveldataforvehicle(function_d93ec4635290febd(), undefined, 1);

  if(!isDefined(leveldataforvehicle)) {
    return;
  }

  function_e1d544cb065687f0(undefined, 0, 1);
  scripts\cp_mp\utility\vehicle_omnvar_utility::vehomn_updateomnvarsondamage(self);
}

function function_9cac3af67ee6b40a(vehicle, player, idamage, idflags, shitloc, smeansofdeath, eattacker, objweapon) {
  seatid = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getoccupantseat(vehicle, player);
  leveldataforvehicle = vehicle_damage_getleveldataforvehicle(vehicle function_d93ec4635290febd());

  if(isDefined(seatid)) {
    seatdata = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getleveldataforseat(vehicle function_d93ec4635290febd(), seatid);

    if(isDefined(leveldataforvehicle.occupantdamagescale) && isDefined(leveldataforvehicle.occupantdamagescale[seatid])) {
      idamage *= leveldataforvehicle.occupantdamagescale[seatid];
    }

    if(isDefined(leveldataforvehicle.occupantdamageclamp) && isDefined(leveldataforvehicle.occupantdamageclamp[seatid])) {
      idamage = clamp(idamage, 0, leveldataforvehicle.occupantdamageclamp[seatid]);
    }

    if(isDefined(seatdata) && isDefined(seatdata.var_dcfc487f4ef1103c) && isDefined(idflags) && idflags & 8 && !(idflags & 16384) && !player isinvehicleleanout() && !(isheadshot(shitloc, smeansofdeath, eattacker) && isDefined(objweapon) && weaponclass(objweapon) == "sniper")) {
      idamage *= seatdata.var_dcfc487f4ef1103c;
    }
  }

  return idamage;
}

function function_f7123f6d38d50909() {
  self endon("death");
  function_a913d098054d5bce();
  castcontents = physics_createcontents(["physicscontents_missileclip", "physicscontents_vehicle", "physicscontents_glass", "physicscontents_water", "physicscontents_item"]);

  while(true) {
    if(!isDefined(self.reactivearmor) || self.reactivearmor.size == 0 || !isDefined(self.origin)) {
      break;
    }

    if(istrue(self.reactivearmordisabled)) {
      waitframe();
      continue;
    }

    friendlyteam = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getteamfriendlyto(self);
    scripts\cp_mp\utility\game_utility::createprojectilepartition();

    foreach(projectilearray in level.projectilepartition function_df633f460888a47(self.origin)) {
      foreach(projectile in projectilearray) {
        if(!isDefined(projectile) || !isDefined(projectile.origin)) {
          continue;
        }

        if(distancesquared(projectile.origin, self.origin) > 160000) {
          continue;
        }

        owner = projectile.owner;

        if(!isDefined(owner) && isDefined(projectile.weapon_name) && weaponclass(projectile.weapon_name) == "grenade") {
          owner = getmissileowner(projectile);
        }

        var_f31940d93afc41db = 1;

        if(getdvarint(@ "hash_3c6c485214ca7673", 0) == 1) {
          var_f31940d93afc41db = 0;
        }

        if(var_f31940d93afc41db && isDefined(owner) && is_equal(friendlyteam, owner.team)) {
          continue;
        }

        if(getdvarint(@ "hash_b16f847dc3049239")) {
          sphere(projectile.origin, 15, (1, 0, 0));
        }

        projectileorigin = projectile.origin;

        foreach(tagname, data in self.reactivearmor) {
          tagorigin = self gettagorigin(tagname);
          totag = projectileorigin - tagorigin;
          angle = math::anglebetweenvectors(totag, anglesToForward(self gettagangles(tagname)));

          if(angle > 30) {
            continue;
          }

          castresults = physics_raycast(tagorigin, projectileorigin, castcontents, [self, projectile], 0, "physicsquery_closest");

          if(isDefined(castresults) && castresults.size > 0) {
            continue;
          }

          isleft = issubstr(tagname, "left");
          var_eaba477d71b264e6 = undefined;

          foreach(othertag, data in array_randomize_objects(self.reactivearmor)) {
            if(othertag == tagname || issubstr(othertag, "left") != isleft) {
              continue;
            }

            var_eaba477d71b264e6 = othertag;
            break;
          }

          self.damageableparts[tagname].healthvalue = 0;
          function_77db32aa48a42a76(self, tagname, undefined, 1);

          if(isDefined(var_eaba477d71b264e6)) {
            self.damageableparts[var_eaba477d71b264e6].healthvalue = 0;
            function_77db32aa48a42a76(self, var_eaba477d71b264e6, undefined, 1);
          }

          function_577bb0f5a3fcc2bc(projectile);
          break;
        }
      }
    }

    if(getdvarint(@ "hash_b16f847dc3049239")) {
      sphere(self.origin, 400, (0, 0, 1));

      foreach(tagname, data in self.reactivearmor) {
        start = self gettagorigin(tagname);
        end = start + anglesToForward(self gettagangles(tagname)) * 250;
        line(start, end, (0, 0, 1));
      }
    }

    waitframe();
  }
}

function function_577bb0f5a3fcc2bc(target) {
  target setCanDamage(0);
  target.exploding = 1;
  target stopsounds();

  if(!isDefined(target.owner)) {
    return;
  }

  if(isPlayer(target.owner)) {
    target.owner scripts\cp_mp\damagefeedback::updatedamagefeedback("reactivearmorexplosion");
  }

  self.reactivearmorexplosion dontinterpolate();
  self.reactivearmorexplosion.origin = target.origin;
  up = target.origin - self.origin;
  right = up + (1, 0, 0);
  forward = vectorcross(up, right);
  right = vectorcross(forward, up);
  self.reactivearmorexplosion.angles = axistoangles(forward, right, up);

  if(istrue(self.explode1available)) {
    self.reactivearmorexplosion setscriptablepartstate("explode1", "activeDirectional", 0);
    self.explode1available = 0;
  } else {
    self.reactivearmorexplosion setscriptablepartstate("explode2", "activeDirectional", 0);
    self.explode1available = 1;
  }

  if(isDefined(target.streakname) && target.streakname == "cruise_predator") {
    target notify("trophy_blocked");
    return;
  }

  target delete();
}

function function_a913d098054d5bce() {
  explosion = spawn("script_model", self.origin);
  explosion setModel("trophy_system_mp_explode");
  self.explode1available = 1;
  self.reactivearmorexplosion = explosion;
}

function function_870cbf6ca47076b6(vehicleref) {
  return vehicle_damage_getleveldataforvehicle(vehicleref).var_9d70f02394c136da;
}

function function_32b9b5d07bb56c31(vehicleref) {
  return vehicle_damage_getleveldataforvehicle(vehicleref).var_ccfde1208ef2964b;
}

function function_bc320cf9a1b27cb5(vehicleref, tagname, var_b4fccc158c681073, var_1c60586652067d4c) {
  leveldataforvehicle = vehicle_damage_getleveldataforvehicle(vehicleref);

  if(isDefined(var_b4fccc158c681073)) {
    leveldataforvehicle.damageableparts[tagname].var_b4fccc158c681073 = var_b4fccc158c681073;
  }

  if(isDefined(var_1c60586652067d4c)) {
    leveldataforvehicle.damageableparts[tagname].var_1c60586652067d4c = var_1c60586652067d4c;
  }
}

function function_1f39191797c711b6(vehicleref, expdamageradiussq) {
  leveldataforvehicle = vehicle_damage_getleveldataforvehicle(vehicleref);
  leveldataforvehicle.expdamageradiussq = expdamageradiussq;
}

function function_268e0e5863858dcf(vehicle, spawndata) {
  leveldataforvehicle = vehicle_damage_getleveldataforvehicle(vehicle function_d93ec4635290febd(), 0, 1);
  ishusk = vehicle isvehiclehusk();
  tags = undefined;

  if(isDefined(spawndata.damageableparts)) {
    tags = spawndata.damageableparts;
  } else if(ishusk) {
    tags = leveldataforvehicle.var_ccfde1208ef2964b;
  } else {
    tags = leveldataforvehicle.var_9d70f02394c136da;
  }

  if(isDefined(tags)) {
    vehicle.damageableparts = [];

    foreach(tagname, damageablepartdata in tags) {
      if(istrue(damageablepartdata.inactive)) {
        continue;
      }

      var_1c09c3e40955f379 = spawnStruct();
      var_1c09c3e40955f379.healthvalue = damageablepartdata.healthvalue;
      var_1c09c3e40955f379.explosivedamagehealthvalue = damageablepartdata.explosivedamagehealthvalue;
      vehicle.damageableparts[tagname] = var_1c09c3e40955f379;

      if(istrue(damageablepartdata.isreactivearmor) && !ishusk) {
        if(!isDefined(vehicle.reactivearmor)) {
          vehicle.reactivearmor = [];
        }

        vehicle.reactivearmor[tagname] = var_1c09c3e40955f379;
      }
    }
  }

  if(isDefined(vehicle.reactivearmor)) {
    vehicle thread function_f7123f6d38d50909();
  }
}

function function_963f1cb109b9c186(vehicle, tag) {
  if(!isDefined(vehicle) || !isDefined(tag)) {
    return 0;
  }

  data = vehicle_damage_getleveldataforvehicle(vehicle function_d93ec4635290febd());
  tags = undefined;

  if(vehicle isvehiclehusk()) {
    tags = data.var_ccfde1208ef2964b;
  } else {
    tags = data.var_9d70f02394c136da;
  }

  if(!isDefined(tags[tag])) {
    return 0;
  }

  damageablepartdata = spawnStruct();
  damageablepartdata.healthvalue = tags[tag].healthvalue;
  damageablepartdata.explosivedamagehealthvalue = tags[tag].explosivedamagehealthvalue;

  if(!isDefined(vehicle.damageableparts)) {
    vehicle.damageableparts = [];
  }

  vehicle.damageableparts[tag] = damageablepartdata;
  vehicle setscriptablepartstate(tag, "default");
}

function function_152437480e61a8a2(vehicle, damagedata, unmodifieddamage) {
  damagemultiplier = 1;
  tagnames = function_786c7ec25aad5005(vehicle, damagedata);
  ref = vehicle function_d93ec4635290febd();
  vehicledata = vehicle_damage_getleveldataforvehicle(ref);

  if(getdvarint(@ "hash_d6a84652bcb25596", 0) == 1 && tagnames.size > 0) {
    string = "<dev string:x1c>";

    foreach(tag in tagnames) {
      string += tag + "<dev string:x22>";
    }

    string += "<dev string:x25>" + unmodifieddamage;
    iprintlnbold(string);
  }

  foreach(tagname in tagnames) {
    if(!function_6e87d9e8601d9029(vehicle, tagname, damagedata)) {
      continue;
    }

    var_fc00c9efa9cebdbc = vehicle.damageableparts[tagname].healthvalue;
    damage = max(0, unmodifieddamage - function_c9f618f05861c2c5(ref, tagname));
    var_f943483e687a2247 = max(0, var_fc00c9efa9cebdbc - damage);
    vehicle.damageableparts[tagname].healthvalue = var_f943483e687a2247;

    if(isexplosivedamagemod(damagedata.meansofdeath)) {
      var_858e06144ffaaf87 = vehicle.damageableparts[tagname].explosivedamagehealthvalue;
      var_9824258c4e398daa = var_858e06144ffaaf87 - unmodifieddamage;
      vehicle.damageableparts[tagname].explosivedamagehealthvalue = max(0, var_9824258c4e398daa);

      if(istrue(vehicledata.damageableparts[tagname].blockexplosivedamage)) {
        damagemultiplier *= 0.33;
      }
    } else if(istrue(vehicledata.damageableparts[tagname].blockbulletdamage)) {
      damagemultiplier = 0.0001;
    }

    if(function_853c0063f08b55e1(vehicle.damageableparts[tagname])) {
      function_77db32aa48a42a76(vehicle, tagname, damagedata);
      continue;
    }

    var_cf8eaf8bc98090a6 = function_dde06c2157ec8895(ref, tagname);

    if(isDefined(var_cf8eaf8bc98090a6)) {
      vehicle thread[[var_cf8eaf8bc98090a6]](vehicle, damagedata);
    }
  }

  return damagemultiplier;
}

function function_9b1b715feb24f29f(vehicle, damagedata) {
  ref = vehicle function_d93ec4635290febd();

  if(!isDefined(ref)) {
    return;
  }

  vehicledata = vehicle_damage_getleveldataforvehicle(ref);

  if(!isDefined(vehicledata)) {
    return;
  }

  partdata = vehicledata.damageableparts;

  if(!isDefined(partdata)) {
    return;
  }

  tagnames = function_786c7ec25aad5005(vehicle, damagedata);

  if(getdvarint(@ "hash_d6a84652bcb25596", 0) == 1 && tagnames.size > 0) {
    string = "<dev string:x1c>";

    foreach(tag in tagnames) {
      string += tag + "<dev string:x22>";
    }

    iprintlnbold(string);
  }

  foreach(tagname in tagnames) {
    if(function_6e87d9e8601d9029(vehicle, tagname, damagedata)) {
      if(!isDefined(partdata[tagname]) || !isDefined(partdata[tagname].windowref)) {
        continue;
      }

      if(isexplosivedamagemod(damagedata.meansofdeath)) {
        var_9824258c4e398daa = vehicle.damageableparts[tagname].explosivedamagehealthvalue - damagedata.damage;
        vehicle.damageableparts[tagname].explosivedamagehealthvalue = max(0, var_9824258c4e398daa);
      } else {
        damage = max(0, damagedata.damage - function_c9f618f05861c2c5(ref, tagname));
        var_f943483e687a2247 = max(0, vehicle.damageableparts[tagname].healthvalue - damage);
        vehicle.damageableparts[tagname].healthvalue = var_f943483e687a2247;
      }

      if(function_853c0063f08b55e1(vehicle.damageableparts[tagname])) {
        function_77db32aa48a42a76(vehicle, tagname, damagedata);
        continue;
      }

      var_cf8eaf8bc98090a6 = function_dde06c2157ec8895(ref, tagname);

      if(isDefined(var_cf8eaf8bc98090a6)) {
        vehicle thread[[var_cf8eaf8bc98090a6]](vehicle, damagedata);
      }
    }
  }
}

function function_77db32aa48a42a76(vehicle, tagname, damagedata, reactivearmorexplosion) {
  deathstatename = function_82cad97b4499e421(vehicle, tagname, reactivearmorexplosion);
  vehicle setscriptablepartstate(tagname, deathstatename);
  var_b4fccc158c681073 = function_bad6c0e32ff1e092(vehicle function_d93ec4635290febd(), tagname);
  damageablepartdata = function_29b4292c92443328(vehicle function_d93ec4635290febd()).damage.damageableparts[tagname];

  if(isDefined(damageablepartdata) && isDefined(damageablepartdata.wheelref)) {
    if(!isDefined(vehicle.deadwheels)) {
      vehicle.deadwheels = [];
    }

    vehicle.deadwheels[tagname] = damageablepartdata;
  }

  if(isDefined(damageablepartdata) && isDefined(damageablepartdata.windowref)) {
    vehicle callsharedfunc("pmc_missions", "onShatterWindow", damagedata);
  }

  if(isDefined(damageablepartdata) && isDefined(damageablepartdata.doorref)) {
    if(!isDefined(vehicle.var_41e6777f1fa66044)) {
      vehicle.var_41e6777f1fa66044 = [];
    }

    vehicle.var_41e6777f1fa66044[damageablepartdata.doorref] = 1;

    if(vehicle function_452936099dcd1b94(damageablepartdata.doorref)) {
      vehicle function_14219d4c7d83499f(damageablepartdata.doorref);
    }

    occupant = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getseatoccupant(vehicle, damageablepartdata.doorref);

    if(isDefined(occupant)) {
      occupant val::set("vehicle_occupant", "vehicle_lean_out", 0);
      scripts\cp_mp\utility\vehicle_omnvar_utility::vehomn_setcurrentseat(vehicle, damageablepartdata.doorref, occupant);
    }
  }

  if(isDefined(damageablepartdata) && istrue(damageablepartdata.isreactivearmor) && isDefined(vehicle.reactivearmor)) {
    vehicle.reactivearmor[tagname] = undefined;
  }

  if(isDefined(var_b4fccc158c681073)) {
    vehicle thread[[var_b4fccc158c681073]](vehicle, damagedata);
  }
}

function function_b9d5a379eb1aefc7(seatref) {
  return !isDefined(self) || !isDefined(self.var_41e6777f1fa66044) || !istrue(self.var_41e6777f1fa66044[seatref]);
}

function function_ec4b6f058d183338(vehicle, damagedata) {
  if(isDefined(vehicle.damageableparts)) {
    foreach(data in vehicle.damageableparts) {
      if(!function_853c0063f08b55e1(data)) {
        function_77db32aa48a42a76(vehicle, tagname, damagedata);
      }
    }
  }
}

function function_19953ff235374847(vehicle) {
  data = vehicle_damage_getleveldataforvehicle(vehicle function_d93ec4635290febd());
  tags = undefined;

  if(vehicle isvehiclehusk()) {
    tags = data.var_ccfde1208ef2964b;
  } else {
    tags = data.var_9d70f02394c136da;
  }

  foreach(data in tags) {
    function_963f1cb109b9c186(vehicle, tag);
  }
}

function function_9542eac6997b9060(vehicle) {
  if(isDefined(vehicle.damageableparts)) {
    damageablepartdata = function_2265b277a0dad0f1(vehicle function_d93ec4635290febd());

    if(!isDefined(vehicle.randomwindows)) {
      windows = [];

      foreach(tagname, data in vehicle.damageableparts) {
        if(isDefined(damageablepartdata[tagname].windowref)) {
          windows[tagname] = data;
        }
      }

      vehicle.randomwindows = array_randomize_objects(windows);
    }

    foreach(tagname, data in vehicle.randomwindows) {
      if(!function_853c0063f08b55e1(data)) {
        data.healthvalue = max(0, data.healthvalue - randomintrange(50, 125));

        if(function_853c0063f08b55e1(data)) {
          function_77db32aa48a42a76(vehicle, tagname);
          vehicle.randomwindows[tagname] = undefined;
        }

        break;
      }

      vehicle.randomwindows[tagname] = undefined;
    }
  }
}

function function_66ac97eba6b35b4a(vehicle, tagname, damagedata) {
  scriptablepartname = function_f7df41d3ad15dca8(vehicle function_d93ec4635290febd(), tagname);
  vehicle setscriptablepartstate(scriptablepartname, "hide");
  var_b4fccc158c681073 = function_bad6c0e32ff1e092(vehicle function_d93ec4635290febd(), tagname);

  if(isDefined(var_b4fccc158c681073)) {
    vehicle thread[[var_b4fccc158c681073]](vehicle, damagedata);
  }
}

function function_4b3ef3d76f7e39b6(vehicle, damagedata) {
  function_7143b00f866ef1ec(vehicle, 0, damagedata);
}

function function_d4c899afe6cbf533(vehicle, damagedata) {
  function_7143b00f866ef1ec(vehicle, 1, damagedata);
}

function function_1c35d2bee2c14d7b(vehicle, damagedata) {
  function_7143b00f866ef1ec(vehicle, 2, damagedata);
}

function function_2e20b5a5d4f70228(vehicle, damagedata) {
  function_7143b00f866ef1ec(vehicle, 3, damagedata);
}

function function_79b9f63570444468(vehicle, damagedata) {
  function_7143b00f866ef1ec(vehicle, 4, damagedata);
}

function function_4c7a8d0b6c6c16cd(vehicle, damagedata) {
  function_7143b00f866ef1ec(vehicle, 5, damagedata);
}

function function_1cbe55c0515820b5(vehicle, damagedata) {
  function_7143b00f866ef1ec(vehicle, 6, damagedata);
}

function function_6469ea91038491e2(vehicle, damagedata) {
  function_7143b00f866ef1ec(vehicle, 7, damagedata);
}

function private function_7143b00f866ef1ec(vehicle, tireindex, damagedata) {
  vehicle blowuptire(tireindex);

  if(!isDefined(vehicle.flattiremask)) {
    vehicle.flattiremask = 0;
  }

  vehicle.flattiremask |= 1 << tireindex;
  occupants = scripts\cp_mp\vehicles\vehicle_occupancy::function_efa75aa7f0a1289(self, 0);

  if(isDefined(occupants)) {
    foreach(occupant in occupants) {
      function_eae2223216b7712c(vehicle, occupant);
    }
  }

  tagname = undefined;

  if(isDefined(damagedata) && isDefined(damagedata.partname) && isstring(damagedata.partname) && damagedata.partname != "") {
    tagname = damagedata.partname;
  } else if(isDefined(damagedata) && isDefined(damagedata.attachtagname) && isstring(damagedata.attachtagname) && damagedata.attachtagname != "") {
    tagname = damagedata.attachtagname;
  }

  if(isDefined(vehicle) && isDefined(vehicle.origin) && isDefined(tagname) && vehicle vehicle_isphysveh()) {
    data = function_29b4292c92443328(vehicle function_d93ec4635290febd());
    speed = vehicle vehicle_getspeed();
    maxspeed = vehicle vehicle_gettopspeedforward();
    force = math::normalize_value(0, maxspeed / 2, speed);
    force = force * 0.8 + 0.2;
    force *= data.damage.var_96f121d1edfdb0cb;
    self vehphys_impulse(vehicle.origin - vehicle gettagorigin(tagname) + (0, 0, 300), int(255 * force), 1);
  }

  if(!vehicle isvehiclehusk() && isDefined(damagedata) && isDefined(damagedata.attacker) && isPlayer(damagedata.attacker)) {
    isenemy = scripts\cp_mp\vehicles\vehicle::vehicle_isenemytoplayer(vehicle, damagedata.attacker);
    damagedata.givepointsandxp = isenemy;
    damagedata.attacker vehicle_damage_givescoreandxpatframeend(#"hash_5db50bf1147f0f52", undefined, damagedata, vehicle);
    vehicle callsharedfunc("pmc_missions", "onPopTire", damagedata.attacker, isenemy);
  }
}

function private function_79a4d42ef833438a() {
  scripts\engine\scriptable::scriptable_addusedcallback(&function_4b8d35d7af7fd960);
}

function function_4b8d35d7af7fd960(instance, part, state, player, bautouse, usestring) {
  if(!isDefined(usestring) || !isDefined(instance) || !isDefined(instance.entity) || !instance.entity isvehicle()) {
    return;
  }

  if(usestring == "row1_left" || usestring == "row1_right" || usestring == "row2_left" || usestring == "row2_right" || usestring == "row3_left" || usestring == "row3_right" || usestring == "row4_left" || usestring == "row4_right") {
    function_770f9f7300665(instance.entity, instance, part, usestring, player, 0);
  }
}

function function_e6f68a61bffc259a(vehicle) {
  if(isDefined(vehicle.deadwheels)) {
    foreach(data in vehicle.deadwheels) {
      function_770f9f7300665(vehicle, vehicle, part, data.wheelref, undefined, 1);
      break;
    }
  }
}

function function_9ae605ed3dc3bd1(vehicle) {
  if(isDefined(vehicle.deadwheels)) {
    foreach(data in vehicle.deadwheels) {
      vehicle thread function_770f9f7300665(vehicle, vehicle, part, data.wheelref, undefined, 1);
    }
  }
}

function private function_770f9f7300665(vehicle, scriptable, part, tirename, player, var_2b5043846177fbc9) {
  vehicle endon("death");

  if(isDefined(player)) {
    player thread function_3bde2944d834b090();
    player callback::callback("on_vehicle_tire_repaired");
  }

  scriptable setscriptablepartstate(part, "repaired");
  wait 0.1;
  tireindex = function_948c6c379e1a9b52(tirename);
  vehicle pristinetire(tireindex);

  if(isDefined(vehicle.deadwheels) && isDefined(vehicle.deadwheels[part])) {
    vehicle.damageableparts[part].healthvalue = vehicle.deadwheels[part].healthvalue;
    vehicle.damageableparts[part].explosivedamagehealthvalue = vehicle.deadwheels[part].explosivedamagehealthvalue;
  }

  if(!isDefined(vehicle.flattiremask)) {
    vehicle.flattiremask = 0;
  }

  vehicle.flattiremask &= ~(1 << tireindex);
  occupants = scripts\cp_mp\vehicles\vehicle_occupancy::function_efa75aa7f0a1289(vehicle, 0);

  if(isDefined(occupants)) {
    foreach(occupant in occupants) {
      function_eae2223216b7712c(vehicle, occupant);
      occupant callback::callback("on_vehicle_tire_repaired");
    }
  }

  vehicle.deadwheels[part] = undefined;

  if(vehicle.deadwheels.size == 0) {
    vehicle.deadwheels = undefined;
  }

  function_c3da7bb5f5499152(vehicle, part, var_2b5043846177fbc9);
}

function private function_3bde2944d834b090() {
  self endon("death_or_disconnect");
  weapobj = makeweapon("iw8_ges_plyr_loot_pickup");
  self giveandfireoffhand(weapobj);
  wait 1.17;

  if(self hasweapon(weapobj)) {
    self takeweapon(weapobj);
  }
}

function private function_c3da7bb5f5499152(vehicle, part, var_2b5043846177fbc9) {
  repairsoundlocation = vehicle gettagorigin(part);
  repairsound = "veh_repair_tire";

  if(var_2b5043846177fbc9) {
    repairsound = "veh_repair_tire_at_station";
  }

  playsoundatpos(repairsoundlocation, repairsound);
}

function private function_948c6c379e1a9b52(tirename) {
  switch (tirename) {
    case #"hash_19baa7ca5b52f06a":
      return 0;
    case #"hash_60b26be014fd7337":
      return 1;
    case #"hash_67ed6be3637f19ed":
      return 2;
    case #"hash_227fe4df4167aa26":
      return 3;
    case #"hash_f0704f57a0dd2250":
      return 4;
    case #"hash_cbd67f63f80e6245":
      return 5;
    case #"hash_711797dce2a722a3":
      return 6;
    case #"hash_6ade103971ce6e2c":
      return 7;
    default:
      assert("vehicle_damage_tireNameToIndex Not given a valid tire name");
      break;
  }
}

function function_eae2223216b7712c(vehicle, player) {
  if(!isDefined(vehicle.flattiremask)) {
    vehicle.flattiremask = 0;
  }

  player setclientomnvar("ui_veh_flat_tire_mask", vehicle.flattiremask);
}

function function_b9d933a7b78a67ad(data) {
  if(!isDefined(data.inflictor) || !isagent(data.inflictor)) {
    return data.damage;
  }

  ref = function_d93ec4635290febd();

  if(!isDefined(ref) || !function_89dc39dc11f3988c(ref)) {
    return data.damage;
  }

  vehicledata = function_29b4292c92443328(ref);

  if(!isDefined(vehicledata) || !isDefined(vehicledata.damage) || !isDefined(vehicledata.damage.agentdamagemultiplier)) {
    return data.damage;
  }

  return data.damage * vehicledata.damage.agentdamagemultiplier;
}

function function_c5a55810ed63c87d(data) {
  if(!isDefined(data.point) || !isDefined(data.objweapon) || !isDefined(data.objweapon.damageradius)) {
    return true;
  }

  ref = function_d93ec4635290febd();

  if(!isDefined(ref) || !function_89dc39dc11f3988c(ref)) {
    return true;
  }

  vehicledata = function_29b4292c92443328(ref);

  if(!isDefined(vehicledata) || !isDefined(vehicledata.damage) || !isDefined(vehicledata.damage.explosionextents)) {
    return true;
  }

  radius = data.objweapon.damageradius;
  bounds = vehicledata.damage.explosionextents;
  localorigin = coordtransformtranspose(data.point, self.origin, self.angles);
  return localorigin[0] > (bounds.back + radius) * -1 && localorigin[0] < bounds.front + radius && localorigin[1] > (bounds.left + radius) * -1 && localorigin[1] < bounds.right + radius && localorigin[2] > (bounds.bottom + radius) * -1 && localorigin[2] < bounds.top + radius;
}

function vehicle_damage_init() {
  assertex(isDefined(level.vehicle), "vehicle_damage_init() called before vehicle_init().");
  assertex(!isDefined(level.vehicle.damage), "vehicle_damage_init() should only be called once.");
  leveldata = spawnStruct();
  level.vehicle.damage = leveldata;
  level.var_ec75ca2494d74dab = getdvarint(@ "hash_4421544b585f6be5", utility::ismp()) == 1;
  level.deathanimsenabled = getdvarint(@ "hash_6fc86a5e3cedbd94", 0) == 1;
  leveldata.vehicledata = [];
  leveldata.heavystatehealthadd = getdvarint(@ "hash_a3b9b8945213c089", 350);
  leveldata.mediumstatehealthratio = getdvarfloat(@ "hash_4217d1e671e33953", 0.5);
  leveldata.burndowntime = getdvarfloat(@ "hash_1021d59d6f0d99a0", 8);
  vehicle_damage_loadtable();
  vehicle_damage_initdebug();

  if(issharedfuncdefined("vehicle_damage", "init")) {
    [[getsharedfunc("vehicle_damage", "init")]]();
  }

  issharedfuncdefined("<dev string:x2f>", "<dev string:x3e>", 1);

  issharedfuncdefined("<dev string:x2f>", "<dev string:x60>", 1);

  issharedfuncdefined("<dev string:x2f>", "<dev string:x71>", 1);

  issharedfuncdefined("<dev string:x2f>", "<dev string:x88>", 1);

  issharedfuncdefined("<dev string:x2f>", "<dev string:xa9>", 1);

  issharedfuncdefined("<dev string:x2f>", "<dev string:xc1>", 1);

  issharedfuncdefined("<dev string:x2f>", "<dev string:xe2>", 1);

  issharedfuncdefined("<dev string:x2f>", "<dev string:xfa>", 1);

  issharedfuncdefined("<dev string:x2f>", "<dev string:x113>", 1);

  if(scripts\cp_mp\utility\game_utility::isbrstylegametype()) {
    vehicle_damage_inithitdamage_br();
  } else {
    vehicle_damage_inithitdamage();
  }

  vehicle_damage_initmoddamage();
  function_79a4d42ef833438a();
}

function vehicle_damage_loadtable() {
  leveldata = vehicle_damage_getleveldata();
  table = spawnStruct();
  leveldata.table = table;
  table.modsforclass = [];
  table.modsforvehicle = [];
  table.hitsperattackforclass = [];
  table.hitsperattackforvehicle = [];
  table.skipburndownforclass = [];
  table.skipburndownforvehicle = [];
  var_b271a3d0c941cd5c = [];
  var_b271a3d0c941cd5c["class"] = [];
  var_b271a3d0c941cd5c["vehicle"] = [];
  var_870d49f076632bf2 = [];
  var_870d49f076632bf2["weaponMod"] = [];
  var_870d49f076632bf2["weaponHPA"] = [];
  var_870d49f076632bf2["weaponSkipBurnDown"] = [];

  if(getDvar(@ "scr_vehicle_damage_table", "") != "") {
    table = getDvar(@ "scr_vehicle_damage_table", "");
  } else {
    table = "mp_cp/vehicleDamageTable.csv";
  }

  colcategory = undefined;
  numcols = tablelookupgetnumcols(table);

  for(numcol = 1; numcol < numcols; numcol++) {
    colstr = tablelookupbyrow(table, 0, numcol);

    if(isDefined(colstr) && colstr != "") {
      if(getsubstr(colstr, 0, 1) == "*") {
        colcategory = getsubstr(colstr, 1, colstr.size);
        continue;
      }

      if(isDefined(var_b271a3d0c941cd5c[colcategory])) {
        var_b271a3d0c941cd5c[colcategory][colstr] = numcol;
      }
    }
  }

  rowcategory = undefined;
  numrow = 0;
  numrows = tablelookupgetnumrows(table);

  for(numrow = 0; numrow < numrows; numrow++) {
    rowstr = tablelookupbyrow(table, numrow, 1);

    if(isDefined(rowstr) && rowstr != "") {
      if(getsubstr(rowstr, 0, 1) == "*") {
        rowcategory = getsubstr(rowstr, 1, rowstr.size);
        continue;
      }

      if(isDefined(var_870d49f076632bf2[rowcategory])) {
        var_870d49f076632bf2[rowcategory][rowstr] = numrow;
      }
    }
  }

  foreach(rowcategory, var_247c537da346ffde in var_870d49f076632bf2) {
    foreach(rowstr, rownum in var_247c537da346ffde) {
      foreach(colcategory, var_2e078af567792360 in var_b271a3d0c941cd5c) {
        foreach(colstr, colnum in var_2e078af567792360) {
          cellstr = tablelookup(table, 0, rownum, colnum);

          if(isDefined(cellstr) && cellstr != "") {
            vehicle_damage_loadtablecell(cellstr, rowstr, rowcategory, colstr, colcategory);
          }
        }
      }
    }
  }
}

function vehicle_damage_loadtablecell(cellstr, rowstr, rowcategory, colstr, colcategory) {
  leveldata = vehicle_damage_getleveldata();
  table = leveldata.table;

  if(rowcategory == "weaponMod") {
    cellvalue = float(cellstr);

    if(colcategory == "class") {
      if(!isDefined(table.modsforclass[colstr])) {
        table.modsforclass[colstr] = [];
      }

      table.modsforclass[colstr][rowstr] = cellvalue;
    } else if(colcategory == "vehicle") {
      if(!isDefined(table.modsforvehicle[colstr])) {
        table.modsforvehicle[colstr] = [];
      }

      table.modsforvehicle[colstr][rowstr] = cellvalue;
    }
  }

  if(rowcategory == "weaponHPA") {
    cellvalue = int(cellstr);

    if(colcategory == "class") {
      if(!isDefined(table.hitsperattackforclass[colstr])) {
        table.hitsperattackforclass[colstr] = [];
      }

      table.hitsperattackforclass[colstr][rowstr] = cellvalue;
    } else if(colcategory == "vehicle") {
      if(!isDefined(table.hitsperattackforvehicle[colstr])) {
        table.hitsperattackforvehicle[colstr] = [];
      }

      table.hitsperattackforvehicle[colstr][rowstr] = cellvalue;
    }
  }

  if(rowcategory == "weaponSkipBurnDown") {
    cellvalue = int(cellstr) != 0;

    if(colcategory == "class") {
      if(!isDefined(table.skipburndownforclass[colstr])) {
        table.skipburndownforclass[colstr] = [];
      }

      table.skipburndownforclass[colstr][rowstr] = cellvalue;
      return;
    }

    if(colcategory == "vehicle") {
      if(!isDefined(table.skipburndownforvehicle[colstr])) {
        table.skipburndownforvehicle[colstr] = [];
      }

      table.skipburndownforvehicle[colstr][rowstr] = cellvalue;
    }
  }
}

function vehicle_damage_applytabletovehicle(vehicleref, var_6ecb77fd1f27c667) {
  leveldata = vehicle_damage_getleveldata();
  table = leveldata.table;
  leveldataforvehicle = vehicle_damage_getleveldataforvehicle(vehicleref, undefined, var_6ecb77fd1f27c667);

  if(!isDefined(leveldataforvehicle)) {
    return;
  }

  class = leveldataforvehicle.class;

  if(isDefined(table.modsforclass[class])) {
    foreach(weaponclass, mod in table.modsforclass[class]) {
      vehicle_damage_setweaponclassmoddamageforvehicle(weaponclass, mod, 0, vehicleref);
    }
  }

  if(isDefined(table.modsforvehicle[vehicleref])) {
    foreach(mod in table.modsforvehicle[vehicleref]) {
      vehicle_damage_setweaponclassmoddamageforvehicle(weaponclass, mod, 0, vehicleref);
    }
  }

  if(isDefined(table.hitsperattackforclass[class])) {
    foreach(weaponref, hitsperattack in table.hitsperattackforclass[class]) {
      vehicle_damage_setweaponhitdamagedataforvehicle(weaponref, hitsperattack, vehicleref);
      vehicle_damage_setvehiclehitdamagedataforweapon(vehicleref, 100, weaponref);
    }
  }

  if(isDefined(table.hitsperattackforvehicle[vehicleref])) {
    foreach(weaponref, hitsperattack in table.hitsperattackforvehicle[vehicleref]) {
      vehicle_damage_setweaponhitdamagedataforvehicle(weaponref, hitsperattack, vehicleref);
      vehicle_damage_setvehiclehitdamagedataforweapon(vehicleref, 100, weaponref);
    }
  }
}

function vehicle_damage_inithitdamage() {
  vehicle_damage_setweaponhitdamagedata("iw8_la_gromeo_mp", 5);
  vehicle_damage_setweaponhitdamagedata("iw8_la_kgolf_mp", 5);
  vehicle_damage_setweaponhitdamagedata("iw8_la_rpapa7_mp", 5);
  vehicle_damage_setweaponhitdamagedata("iw8_la_juliet_mp", 6);
  vehicle_damage_setweaponhitdamagedata("iw8_la_gromeoks_mp", 4);
  vehicle_damage_setweaponhitdamagedata("iw8_la_mike32_mp", 3);
  vehicle_damage_setweaponhitdamagedata("iw8_ar_mike4_mp", 3);
  vehicle_damage_setweaponhitdamagedata("iw8_ar_akilo47_mp", 3);
  vehicle_damage_setweaponhitdamagedata("iw9_la_gromeo_mp", 5);
  vehicle_damage_setweaponhitdamagedata("iw9_la_juliet_mp", 6);
  vehicle_damage_setweaponhitdamagedata("jup_jp22_la_dromeo_mp", 1);
  vehicle_damage_setweaponhitdamagedata("frag_grenade_mp", 3);
  vehicle_damage_setweaponhitdamagedata("t10_frag_grenade_mp", 3);
  vehicle_damage_setweaponhitdamagedata("jup_frag_grenade_mp", 3);
  vehicle_damage_setweaponhitdamagedata("semtex_mp", 3);
  vehicle_damage_setweaponhitdamagedata("c4_mp", 3);
  vehicle_damage_setweaponhitdamagedata("at_mine_ap_mp", 3);
  vehicle_damage_setweaponhitdamagedata("at_mine_mp", 3);
  vehicle_damage_setweaponhitdamagedata("claymore_mp", 3);
  vehicle_damage_setweaponhitdamagedata("jup_claymore_mp", 3);
  vehicle_damage_setweaponhitdamagedata("jup_claymore_cp", 3);
  vehicle_damage_setweaponhitdamagedata("molotov_mp", 2);
  vehicle_damage_setweaponhitdamagedata("thermite_mp", 1);
  vehicle_damage_setweaponhitdamagedata("thermite_av_mp", 1);
  vehicle_damage_setweaponhitdamagedata("thermite_bolt_mp", 1);
  vehicle_damage_setweaponhitdamagedata("semtex_bolt_mp", 4);
  vehicle_damage_setweaponhitdamagedata("thermite_xmike109_mp", 0.5);
  vehicle_damage_setweaponhitdamagedata("semtex_xmike109_mp", 2);
  vehicle_damage_setweaponhitdamagedata("chopper_gunner_proj_mp", 3);
  vehicle_damage_setweaponhitdamagedata("missile_turret_proj_mp", 3);
  vehicle_damage_setweaponhitdamagedata("missile_turret_proj_jup_mp", 3);
  vehicle_damage_setweaponhitdamagedata("toma_proj_mp", 3);
  vehicle_damage_setweaponhitdamagedata("cruise_proj_mp", 15);
  vehicle_damage_setweaponhitdamagedata("artillery_mp", 3);
  vehicle_damage_setweaponhitdamagedata("nuke_mp", 15);
  vehicle_damage_setweaponhitdamagedata("gunship_hellfire_mp", 15);
  vehicle_damage_setweaponhitdamagedata("gunship_105mm_mp", 15);
  vehicle_damage_setweaponhitdamagedata("gunship_40mm_mp", 5);
  vehicle_damage_setweaponhitdamagedata("gunship_25mm_mp", 1);
  vehicle_damage_setweaponhitdamagedata("hover_jet_proj_mp", 3);
  vehicle_damage_setweaponhitdamagedata("chopper_gunner_turret_dmz", 40);
  vehicle_damage_setweaponhitdamagedata("loitering_munition_proj_mp", 3);
  vehicle_damage_setweaponhitdamagedata("emp_drone_non_player_mp", 3);
  vehicle_damage_setweaponhitdamagedata("emp_drone_non_player_direct_mp", 5);
}

function vehicle_damage_inithitdamage_br() {
  vehicle_damage_setweaponhitdamagedata("iw8_la_gromeo_mp", 10);
  vehicle_damage_setweaponhitdamagedata("iw8_la_kgolf_mp", 10);
  vehicle_damage_setweaponhitdamagedata("iw8_la_rpapa7_mp", 10);
  vehicle_damage_setweaponhitdamagedata("iw8_la_juliet_mp", 20);
  vehicle_damage_setweaponhitdamagedata("iw8_la_gromeoks_mp", 10);
  vehicle_damage_setweaponhitdamagedata("iw8_la_mike32_mp", 6);
  vehicle_damage_setweaponhitdamagedata("iw8_ar_mike4_mp", 6);
  vehicle_damage_setweaponhitdamagedata("iw8_ar_akilo47_mp", 6);
  vehicle_damage_setweaponhitdamagedata("iw9_la_gromeo_mp", 10);
  vehicle_damage_setweaponhitdamagedata("iw9_la_juliet_mp", 20);
  vehicle_damage_setweaponhitdamagedata("c4_mp", 13);
  vehicle_damage_setweaponhitdamagedata("semtex_mp", 4);
  vehicle_damage_setweaponhitdamagedata("frag_grenade_mp", 4);
  vehicle_damage_setweaponhitdamagedata("t10_frag_grenade_mp", 4);
  vehicle_damage_setweaponhitdamagedata("jup_frag_grenade_mp", 4);
  vehicle_damage_setweaponhitdamagedata("pop_rocket_mp", 4);
  vehicle_damage_setweaponhitdamagedata("molotov_mp", 2);
  vehicle_damage_setweaponhitdamagedata("at_mine_ap_mp", 5);
  vehicle_damage_setweaponhitdamagedata("at_mine_mp", 13);
  vehicle_damage_setweaponhitdamagedata("thermite_mp", 1);
  vehicle_damage_setweaponhitdamagedata("thermite_av_mp", 1);
  vehicle_damage_setweaponhitdamagedata("emp_grenade_mp", 4);
  vehicle_damage_setweaponhitdamagedata("claymore_mp", 13);
  vehicle_damage_setweaponhitdamagedata("jup_claymore_mp", 13);
  vehicle_damage_setweaponhitdamagedata("jup_claymore_cp", 13);
  vehicle_damage_setweaponhitdamagedata("thermite_bolt_mp", 1);
  vehicle_damage_setweaponhitdamagedata("semtex_bolt_mp", 4);
  vehicle_damage_setweaponhitdamagedata("thermite_xmike109_mp", 0.5);
  vehicle_damage_setweaponhitdamagedata("semtex_xmike109_mp", 2);
  vehicle_damage_setweaponhitdamagedata("toma_proj_mp", 12);
  vehicle_damage_setweaponhitdamagedata("cruise_proj_mp", 15);
  vehicle_damage_setweaponhitdamagedata("artillery_mp", 10);
  vehicle_damage_setweaponhitdamagedata("nuke_mp", 20);
  vehicle_damage_setweaponhitdamagedata("gunship_hellfire_mp", 15);
  vehicle_damage_setweaponhitdamagedata("gunship_105mm_mp", 15);
  vehicle_damage_setweaponhitdamagedata("gunship_40mm_mp", 5);
  vehicle_damage_setweaponhitdamagedata("gunship_25mm_mp", 1);
  vehicle_damage_setweaponhitdamagedata("hover_jet_proj_mp", 3);
  vehicle_damage_setweaponhitdamagedata("loitering_munition_proj_mp", 3);
  vehicle_damage_setweaponhitdamagedata("emp_drone_non_player_mp", 3);
  vehicle_damage_setweaponhitdamagedata("emp_drone_non_player_direct_mp", 5);
}

function vehicle_damage_initmoddamage() {
  vehicle_damage_setperkmoddamage("specialty_armorpiercing", 0.25, 0);
  vehicle_damage_setperkmoddamage("specialty_armorpiercingks", 0.75, 0);
  vehicle_damage_setperkmoddamage("specialty_incendiary", 0.55, 0);
  vehicle_damage_setperkmoddamage("specialty_explosivebullet", 0.75, 0);
}

function vehicle_damage_getleveldata() {
  assertex(isDefined(level.vehicle.damage), "vehicle_damage_getLevelData() called before vehicle_damage_init().");
  return level.vehicle.damage;
}

function vehicle_damage_isselfdamage(vehicle, data) {
  if(isDefined(data.inflictor)) {
    if(data.inflictor == vehicle) {
      return true;
    }

    turrets = vehicle_getturrets(vehicle);

    foreach(turret in turrets) {
      if(data.inflictor == turret) {
        return true;
      }
    }

    if(data.inflictor.classname == "rocket" && isDefined(data.inflictor.vehicle) && data.inflictor.vehicle == vehicle) {
      return true;
    }
  }

  return false;
}

function vehicle_damage_enableownerdamage(vehicle) {
  vehicle.ownerdamageenabled = 1;
}

function vehicle_damage_isownerdamageenabled(vehicle) {
  return istrue(vehicle.ownerdamageenabled);
}

function vehicle_damage_logevent(vehicle, data) {
  if(!isDefined(vehicle.damageevents)) {
    vehicle.damageevents = [];
  }

  vehicle.damageevents[vehicle.damageevents.size] = data;

  if(isDefined(data.attacker) && isDefined(data.attacker.overridefieldupgrade1) && isDefined(data.attacker.super) && data.attacker.overridefieldupgrade1 == "super_suppression_rounds") {
    if(isDefined(data.attacker.super.vehiclehitcount)) {
      data.attacker.super.vehiclehitcount++;
    } else {
      data.attacker.super.vehiclehitcount = 1;
    }
  }

  thread vehicle_damage_cleareventlogatframeend(vehicle);
}

function vehicle_damage_cleareventlog(vehicle) {
  vehicle notify("vehicle_damage_clearEventLog");
  vehicle.damageevents = undefined;
}

function vehicle_damage_cleareventlogatframeend(vehicle) {
  vehicle endon("death");
  vehicle endon("vehicle_damage_clearEventLog");
  vehicle notify("vehicle_damage_clearEventLogAtFrameEnd");
  vehicle endon("vehicle_damage_clearEventLogAtFrameEnd");
  waittillframeend();
  thread vehicle_damage_cleareventlog(vehicle);
}

function vehicle_damage_referevent(vehicle, turret, data) {
  if(!isDefined(data.meansofdeath)) {
    return 0;
  }

  if(!isexplosivedamagemod(data.meansofdeath)) {
    return 0;
  }

  if(!isDefined(data.eventid)) {
    return 0;
  }

  if(isDefined(vehicle.damageevents)) {
    foreach(_data in vehicle.damageevents) {
      if(_data.eventid == data.eventid) {
        return 0;
      }
    }
  }

  if(!isDefined(data.inflictor)) {
    data.inflictor = undefined;
  }

  vehicle endon("death");
  vehicle endon("vehicle_damage_clearEventLog");
  vehicle dodamage(data.damage, data.point, data.attacker, data.inflictor, data.meansofdeath, data.objweapon, data.hitlocation);
  vehicle_damage_logevent(vehicle, data);
}

function vehicle_damage_keepturretalive(vehicle) {
  self endon("death");
  self endon("vehicle_damage_keepTurretAliveEnd");
  self setCanDamage(1);
  self.health = 2147483647;
  self waittill("damage", damage, attacker, direction_vec, point, meansofdeath, modelname, tagname, partname, idflags, objweapon, origin, angles, normal, inflictor, eventid);
  data = packdamagedata(attacker, self, damage, objweapon, meansofdeath, inflictor, point, direction_vec, modelname, partname, tagname, idflags, eventid);
  vehicle_damage_referevent(vehicle, self, data);
  self.health = 2147483647;
}

function vehicle_damage_keepturretaliveend(turret) {
  self notify("vehicle_damage_keepTurretAliveEnd");
  self setCanDamage(0);
}

function vehicle_damage_visualwatchspeedchange(stateref, data) {
  self notify("vehicle_damage_visualStopWatchingSpeedChange");
  self endon("vehicle_damage_visualStopWatchingSpeedChange");
  oldspeedstate = undefined;

  while(isDefined(self)) {
    speedstate = undefined;
    speed = int(self vehicle_getspeed());
    canfly = istrue(scripts\cp_mp\vehicles\vehicle::vehiclecanfly());

    if(canfly && self vehicle_isonground()) {
      speedstate = 0;
    } else if(!canfly && speed <= 3) {
      speedstate = 0;
    } else if(speed <= 25) {
      speedstate = 1;
    } else {
      speedstate = 2;
    }

    if(isDefined(oldspeedstate) && speedstate != oldspeedstate) {
      leveldatafordamagestate = vehicle_damage_getleveldatafordamagestate(function_d93ec4635290febd(), stateref);
      self thread[[leveldatafordamagestate.onentercallback]](stateref, data);
      return;
    }

    oldspeedstate = speedstate;
    wait 0.1;
  }
}

function vehicle_damage_visualstopwatchingspeedchange() {
  self notify("vehicle_damage_visualStopWatchingSpeedChange");
}

function vehicle_damage_lightvisualcallback(data, changed) {
  speed = int(self vehicle_getspeed());
  canfly = istrue(scripts\cp_mp\vehicles\vehicle::vehiclecanfly());

  if(canfly && self vehicle_isonground()) {
    self setscriptablepartstate("damageLight", "stopped", 1);
  } else if(!canfly && speed <= 3) {
    self setscriptablepartstate("damageLight", "stopped", 1);
  } else if(speed <= 25) {
    self setscriptablepartstate("damageLight", "lowSpeed", 1);
  } else {
    self setscriptablepartstate("damageLight", "highSpeed", 1);
  }

  thread vehicle_damage_visualwatchspeedchange("light", data);
}

function vehicle_damage_lightvisualclearcallback(data, changed, fromdeath) {
  vehicle_damage_visualstopwatchingspeedchange();

  if(!self isscriptable()) {
    if(isDefined(self.vehiclename)) {
      ref = self.vehiclename;
    } else {
      ref = "undefined";
    }

    if(isDefined(self.vehicletype)) {
      type = self.vehicletype;
    } else {
      type = "undefined";
    }

    forcesre = "Vehicle is not a scriptable: ref: " + ref + " type: " + type == undefined;
    return;
  }

  if(!self getscriptablehaspart("damageLight")) {
    if(isDefined(self.vehiclename)) {
      ref = self.vehiclename;
    } else {
      ref = "undefined";
    }

    if(isDefined(self.vehicletype)) {
      type = self.vehicletype;
    } else {
      type = "undefined";
    }

    forcesre = "Vehicle does not have damageLight part: ref: " + ref + " type: " + type == undefined;
    return;
  }

  if(!self getscriptableparthasstate("damageLight", "off")) {
    if(isDefined(self.vehiclename)) {
      ref = self.vehiclename;
    } else {
      ref = "undefined";
    }

    if(isDefined(self.vehicletype)) {
      type = self.vehicletype;
    } else {
      type = "undefined";
    }

    forcesre = "Vehicle does not have part damageLight with state off: ref: " + ref + " type: " + type == undefined;
    return;
  }

  self setscriptablepartstate("damageLight", "off", 1);
}

function vehicle_damage_mediumvisualcallback(data, changed) {
  speed = int(self vehicle_getspeed());
  canfly = istrue(scripts\cp_mp\vehicles\vehicle::vehiclecanfly());

  if(canfly && self vehicle_isonground()) {
    self setscriptablepartstate("damageMedium", "stopped", 1);
  } else if(!canfly && speed <= 3) {
    self setscriptablepartstate("damageMedium", "stopped", 1);
  } else if(speed <= 25) {
    self setscriptablepartstate("damageMedium", "lowSpeed", 1);
  } else {
    self setscriptablepartstate("damageMedium", "highSpeed", 1);
  }

  thread vehicle_damage_visualwatchspeedchange("medium", data);
}

function vehicle_damage_mediumvisualclearcallback(data, changed, fromdeath) {
  vehicle_damage_visualstopwatchingspeedchange();
  self setscriptablepartstate("damageMedium", "off", 1);
}

function vehicle_damage_heavyvisualcallback(data, changed) {
  speed = int(self vehicle_getspeed());
  canfly = istrue(scripts\cp_mp\vehicles\vehicle::vehiclecanfly());

  if(canfly && self vehicle_isonground()) {
    self setscriptablepartstate("damageHeavy", "stopped", 1);
  } else if(!canfly && speed <= 3) {
    self setscriptablepartstate("damageHeavy", "stopped", 1);
  } else if(speed <= 25) {
    self setscriptablepartstate("damageHeavy", "lowSpeed", 1);
  } else {
    self setscriptablepartstate("damageHeavy", "highSpeed", 1);
  }

  thread vehicle_damage_visualwatchspeedchange("heavy", data);
}

function vehicle_damage_heavyvisualclearcallback(data, changed, fromdeath) {
  vehicle_damage_visualstopwatchingspeedchange();
  self setscriptablepartstate("damageHeavy", "off", 1);
}

function vehicle_damage_enginevisualcallback(data, changed) {
  self setscriptablepartstate("damageEngine", "explode", 1);

  if(!istrue(scripts\cp_mp\vehicles\vehicle::vehiclecanfly())) {
    scripts\cp_mp\vehicles\vehicle_occupancy::function_d0092c44c5588870();
  }
}

function vehicle_damage_enginevisualclearcallback(data, changed, fromdeath) {
  self setscriptablepartstate("damageEngine", "off", 1);
}

function vehicle_damage_getstate() {
  if(!isDefined(self.damagestateref)) {
    return "pristine";
  }

  return self.damagestateref;
}

function vehicle_damage_setstate(stateref, oldstateref, data) {
  assert(isDefined(stateref) && isDefined(oldstateref) && stateref != oldstateref);
  self notify("damage_state_change");
  ref = function_d93ec4635290febd();

  if(oldstateref != "pristine") {
    var_1f1b237868b2b611 = vehicle_damage_getleveldatafordamagestate(ref, oldstateref);

    if(isDefined(var_1f1b237868b2b611.onexitcallback)) {
      self thread[[var_1f1b237868b2b611.onexitcallback]](stateref, data);
    }
  }

  if(stateref != "pristine") {
    var_1f1b237868b2b611 = vehicle_damage_getleveldatafordamagestate(ref, stateref);

    if(isDefined(var_1f1b237868b2b611.onentercallback)) {
      self thread[[var_1f1b237868b2b611.onentercallback]](oldstateref, data);
    }
  }

  self.damagestateref = stateref;
}

function vehicle_damage_updatestate(data, var_fa10797979c24226, var_6ecb77fd1f27c667) {
  leveldataforvehicle = vehicle_damage_getleveldataforvehicle(function_d93ec4635290febd(), undefined, var_6ecb77fd1f27c667);

  if(!isDefined(leveldataforvehicle)) {
    return;
  }

  self.lasttimedamaged = gettime();
  function_e1d544cb065687f0(data, var_fa10797979c24226, var_6ecb77fd1f27c667);
}

function function_e1d544cb065687f0(data, var_fa10797979c24226, var_6ecb77fd1f27c667) {
  leveldataforvehicle = vehicle_damage_getleveldataforvehicle(function_d93ec4635290febd(), undefined, var_6ecb77fd1f27c667);
  vehiclehealth = self.health;

  if(isDefined(data) && isDefined(data.damage)) {
    vehiclehealth -= int(data.damage);
  }

  beststateref = "pristine";
  var_47073cf5d0921b2c = undefined;
  var_ad8ec7e8a1d06338 = undefined;

  foreach(stateref, statedata in leveldataforvehicle.damagestatedata) {
    assertex(istrue(var_6ecb77fd1f27c667) || stateref != "pristine", "damageStateData cannot have a stateRef of " + "pristine" + ".");
    assertex(istrue(var_6ecb77fd1f27c667) || isDefined(statedata.maxhealth), "damageStateData for " + stateref + " must define maxHealth.");

    if((!isDefined(var_ad8ec7e8a1d06338) || statedata.maxhealth < var_ad8ec7e8a1d06338) && vehiclehealth <= statedata.maxhealth && (!isvehiclehusk() || stateref != "light" && stateref != "medium")) {
      beststateref = stateref;
      var_47073cf5d0921b2c = statedata;
      var_ad8ec7e8a1d06338 = statedata.maxhealth;
    }
  }

  oldstateref = vehicle_damage_getstate();

  if(beststateref != oldstateref) {
    if(!istrue(var_fa10797979c24226)) {
      if(beststateref == "heavy" && (!isDefined(oldstateref) || oldstateref != "heavy")) {
        if(!istrue(self.disableheavystatedamagefloor)) {
          heavystatemaxhealth = scripts\cp_mp\vehicles\vehicle_damage::vehicle_damage_getheavystatemaxhealth(undefined, function_d93ec4635290febd());

          if(isDefined(heavystatemaxhealth)) {
            if(isDefined(data) && isDefined(data.damage) && data.damage != 0) {
              self.health = int(max(self.health, heavystatemaxhealth + data.damage));
            }
          }
        }
      }
    }

    vehicle_damage_setstate(beststateref, oldstateref, data);
  }
}

function vehicle_damage_disablestatedamagefloor(bool) {
  if(bool) {
    self.disableheavystatedamagefloor = 1;
    return;
  }

  self.disableheavystatedamagefloor = undefined;
}

function vehicle_damage_onenterstatelight(oldstateref, data) {
  vehicle_damage_lightvisualcallback(data, 1);
}

function vehicle_damage_onexitstatelight(newstateref, data) {
  vehicle_damage_lightvisualclearcallback(data, 1);
}

function vehicle_damage_onenterstatemedium(oldstateref, data) {
  vehicle_damage_mediumvisualcallback(data, 1);
}

function vehicle_damage_onexitstatemedium(newstateref, data) {
  vehicle_damage_mediumvisualclearcallback(data, 1);
}

function vehicle_damage_onenterstateheavy(oldstateref, data) {
  if(scripts\cp_mp\vehicles\vehicle::isvehiclehusk()) {
    function_d06474f0bc53709d(data);
  } else {
    vehicle_damage_heavyvisualcallback(data, 1);
    vehicle_damage_enginevisualcallback(data, 1);
  }

  if(!isDefined(oldstateref) || oldstateref != "heavy") {
    scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_allowmovement(self, 0);

    if(function_734926fcdbad1fd4()) {
      vehicle_damage_onenterstateheavyscore(oldstateref, data);
    }

    if(!vehicle_damage_shouldskipburndown(data)) {
      thread vehicle_damage_beginburndown(data);
    }
  }
}

function vehicle_damage_onexitstateheavy(newstateref, data) {
  if(isvehiclehusk()) {
    function_27ec7be8325efa3c(data);
  } else {
    vehicle_damage_heavyvisualclearcallback(data, 1);
    vehicle_damage_enginevisualclearcallback(data, 1);
  }

  if(!isDefined(newstateref) || newstateref != "heavy") {
    if(!isvehiclehusk()) {
      scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_allowmovement(self, 1);
    }

    vehicle_damage_endburndown();
  }
}

function vehicle_damage_registerdefaultstates(vehicleref) {
  leveldataforvehicle = vehicle_damage_getleveldataforvehicle(vehicleref, 1);
  leveldatafordamagestate = vehicle_damage_getleveldatafordamagestate(vehicleref, "light", 1);
  leveldatafordamagestate.onentercallback = &vehicle_damage_onenterstatelight;
  leveldatafordamagestate.onexitcallback = &vehicle_damage_onexitstatelight;
  leveldatafordamagestate = vehicle_damage_getleveldatafordamagestate(vehicleref, "medium", 1);
  leveldatafordamagestate.onentercallback = &vehicle_damage_onenterstatemedium;
  leveldatafordamagestate.onexitcallback = &vehicle_damage_onexitstatemedium;
  leveldatafordamagestate = vehicle_damage_getleveldatafordamagestate(vehicleref, "heavy", 1);
  leveldatafordamagestate.onentercallback = &vehicle_damage_onenterstateheavy;
  leveldatafordamagestate.onexitcallback = &vehicle_damage_onexitstateheavy;
  vehicle_damage_updatestatemaxhealthvalues(vehicleref);
}

function function_d06474f0bc53709d(data) {
  self setscriptablepartstate("damageHeavy", "on", 1);
}

function function_27ec7be8325efa3c(data) {
  self setscriptablepartstate("damageHeavy", "off", 1);
  transitionscriptableparts = scripts\cp_mp\vehicles\vehicle_spawn::function_89cda5ba9bfc8d56(self.pristineref);

  if(isDefined(transitionscriptableparts)) {
    foreach(struct in transitionscriptableparts) {
      self setscriptablepartstate(struct.var_1fb6b56a662df98, "off", 1);
    }
  }
}

function vehicle_damage_getmaxhealth(vehicle, vehicleref) {
  if(!isDefined(vehicleref)) {
    vehicleref = vehicle function_d93ec4635290febd();
  }

  leveldata = vehicle_damage_getleveldata();
  leveldataforvehicle = vehicle_damage_getleveldataforvehicle(vehicleref, 1);

  if(!isDefined(leveldataforvehicle)) {
    if(isDefined(vehicle)) {
      return vehicle.maxhealth;
    }

    return undefined;
  }

  if(!isDefined(leveldataforvehicle.health)) {
    if(isDefined(vehicle)) {
      return vehicle.maxhealth;
    }

    return undefined;
  }

  maxhealth = leveldataforvehicle.health;
  heavystatehealthadd = vehicle_damage_getheavystatehealthadd(vehicleref);

  if(isDefined(heavystatehealthadd)) {
    maxhealth += heavystatehealthadd;
  }

  return int(maxhealth);
}

function vehicle_damage_getpristinestateminhealth(vehicle, vehicleref) {
  if(!isDefined(vehicleref)) {
    vehicleref = vehicle function_d93ec4635290febd();
  }

  leveldata = vehicle_damage_getleveldata();
  leveldataforvehicle = vehicle_damage_getleveldataforvehicle(vehicleref, 1);

  if(!isDefined(leveldataforvehicle)) {
    return undefined;
  }

  if(!isDefined(leveldataforvehicle.health)) {
    return undefined;
  }

  pristinestateminhealth = leveldataforvehicle.health * 0.9;
  heavystatehealthadd = vehicle_damage_getheavystatehealthadd(vehicleref);

  if(isDefined(heavystatehealthadd)) {
    pristinestateminhealth += heavystatehealthadd;
  }

  if(!isDefined(pristinestateminhealth) || pristinestateminhealth <= 0) {
    return undefined;
  }

  return int(pristinestateminhealth);
}

function vehicle_damage_getheavystatemaxhealth(vehicle, vehicleref) {
  if(!isDefined(vehicleref)) {
    vehicleref = vehicle function_d93ec4635290febd();
  }

  leveldata = vehicle_damage_getleveldata();
  leveldataforvehicle = vehicle_damage_getleveldataforvehicle(vehicleref);

  if(!isDefined(leveldataforvehicle)) {
    return undefined;
  }

  if(!isDefined(leveldataforvehicle.health)) {
    return undefined;
  }

  heavystatehealthadd = vehicle_damage_getheavystatehealthadd(vehicleref);

  if(!isDefined(heavystatehealthadd) || heavystatehealthadd <= 0) {
    return undefined;
  }

  return int(heavystatehealthadd);
}

function vehicle_damage_updatestatemaxhealthvalues(vehicleref) {
  leveldataforvehicle = vehicle_damage_getleveldataforvehicle(vehicleref);
  assertex(isDefined(leveldataforvehicle.health), "vehicle_damage_updateStateMaxHealthValues called on a vehicle whose level data has not assigned .health.");
  minhealth = undefined;
  maxhealth = undefined;

  foreach(stateref, statedata in leveldataforvehicle.damagestatedata) {
    if(stateref == "light") {
      statedata.maxhealth = vehicle_damage_getpristinestateminhealth(undefined, vehicleref);
      maxhealth = statedata.maxhealth;
      continue;
    }

    if(stateref == "heavy") {
      statedata.maxhealth = vehicle_damage_getheavystatemaxhealth(undefined, vehicleref);
      minhealth = statedata.maxhealth;
    }
  }

  statedata = leveldataforvehicle.damagestatedata["medium"];

  if(isDefined(statedata)) {
    if(isDefined(minhealth) && isDefined(maxhealth)) {
      ratio = vehicle_damage_getmediumstatehealthratio(vehicleref);

      if(isDefined(ratio)) {
        statedata.maxhealth = int(math::lerp(minhealth, maxhealth, ratio));
      }
    }
  }
}

function vehicle_damage_getheavystatehealthadd(vehicleref) {
  leveldata = vehicle_damage_getleveldata();
  leveldataforvehicle = vehicle_damage_getleveldataforvehicle(vehicleref);
  heavystatehealthadd = leveldataforvehicle.heavystatehealthadd;

  if(!isDefined(heavystatehealthadd)) {
    heavystatehealthadd = leveldata.heavystatehealthadd;
  }

  if(!isDefined(heavystatehealthadd) || heavystatehealthadd <= 0) {
    return undefined;
  }

  return int(heavystatehealthadd);
}

function vehicle_damage_getmediumstatehealthratio(vehicleref) {
  leveldata = vehicle_damage_getleveldata();
  leveldataforvehicle = vehicle_damage_getleveldataforvehicle(vehicleref);
  mediumstatehealthratio = leveldataforvehicle.mediumstatehealthratio;

  if(!isDefined(mediumstatehealthratio)) {
    mediumstatehealthratio = leveldata.mediumstatehealthratio;
  }

  if(!isDefined(mediumstatehealthratio) || mediumstatehealthratio <= 0 || mediumstatehealthratio > 1) {
    return undefined;
  }

  return mediumstatehealthratio;
}

function function_1989bd346c21b68a(data) {
  if(isDefined(data.inflictor) && isDefined(data.inflictor.weapon_name) && data.inflictor.weapon_name == "gl") {
    return (isDefined(data.meansofdeath) && data.meansofdeath == "MOD_GRENADE");
  }

  if(isDefined(data.objweapon) && isDefined(data.objweapon.basename)) {
    switch (data.objweapon.basename) {
      case #"hash_708fb6e22f87a3a4":
      case #"hash_a622e958420b92a0":
        return (isDefined(data.meansofdeath) && (data.meansofdeath == "MOD_PROJECTILE" || data.meansofdeath == "MOD_RIFLE_BULLET"));
      case #"hash_13a265ac820ea0df":
      case #"hash_1717a0115ff7a1c4":
      case #"hash_3e782fd775b72022":
      case #"hash_5c272c0617caebf0":
      case #"hash_8c12df11df01f306":
      case #"hash_a86d4075406d2de4":
      case #"hash_fd9c279f85990dad":
        return (isDefined(data.meansofdeath) && data.meansofdeath == "MOD_PROJECTILE");
      case #"hash_c500a77b6bb7c5d0":
        return (isDefined(data.meansofdeath) && data.meansofdeath == "MOD_GRENADE");
      case #"hash_56ee829cc162271a":
        return (isDefined(data.meansofdeath) && data.meansofdeath == "MOD_EXPLOSIVE");
    }
  }

  return false;
}

function function_6e87d9e8601d9029(vehicle, tagname, damagedata) {
  if(!isDefined(vehicle.damageableparts)) {
    return 0;
  }

  if(!isDefined(tagname)) {
    return 0;
  }

  if(!isDefined(vehicle.damageableparts[tagname])) {
    return 0;
  }

  if(function_853c0063f08b55e1(vehicle.damageableparts[tagname])) {
    return 0;
  }

  if(isDefined(damagedata) && isDefined(damagedata.objweapon) && (istrue(callsharedfunc("weapons", "isThrowingKnife", damagedata.objweapon)) || istrue(callsharedfunc("weapons", "isThrowStar", damagedata.objweapon)))) {
    damageablepartdata = function_2265b277a0dad0f1(vehicle function_d93ec4635290febd());

    if(!isDefined(damageablepartdata[tagname].wheelref)) {
      return 0;
    }
  }

  if(isDefined(damagedata) && isDefined(damagedata.objweapon) && isDefined(damagedata.meansofdeath) && damagedata.meansofdeath == "MOD_MELEE") {
    damageablepartdata = function_2265b277a0dad0f1(vehicle function_d93ec4635290febd());
    issharp = scripts\cp_mp\utility\weapon_utility::issharpmeleeweapon(damagedata.objweapon);
    iswindow = isDefined(damageablepartdata[tagname].windowref);
    istire = isDefined(damageablepartdata[tagname].wheelref);

    if(issharp && !iswindow && !istire) {
      return 0;
    } else if(!issharp && !iswindow) {
      return 0;
    }
  }

  state = vehicle getscriptablepartstate(tagname, 1);

  if(isDefined(state) && state == "start_hidden") {
    return 0;
  }

  damagefilterfunc = function_14cc373f72a021a8(vehicle function_d93ec4635290febd(), tagname);

  if(isDefined(damagefilterfunc)) {
    return [[damagefilterfunc]](damagedata);
  }

  return 1;
}

function function_452936099dcd1b94(seatid) {
  data = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getleveldataforvehicle(function_d93ec4635290febd());
  return isDefined(data.seatdata[seatid]) && isDefined(data.seatdata[seatid].doorwindowref) && isDefined(self.damageableparts) && isDefined(self.damageableparts[data.seatdata[seatid].doorwindowref]) && !function_853c0063f08b55e1(self.damageableparts[data.seatdata[seatid].doorwindowref]);
}

function function_14219d4c7d83499f(seatid) {
  data = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getleveldataforvehicle(function_d93ec4635290febd());

  if(isDefined(data.seatdata[seatid]) && isDefined(data.seatdata[seatid].doorwindowref)) {
    self.damageableparts[data.seatdata[seatid].doorwindowref].healthvalue = 0;
    function_77db32aa48a42a76(self, data.seatdata[seatid].doorwindowref);
  }
}

function function_e6ec777562579771(vehicle, seatid) {
  self endon("death_or_disconnect");
  self endon("vehicle_seat_exit");
  waittill_any_2("vehicle_leanout_begin", "roof_exit");

  if(vehicle function_452936099dcd1b94(seatid)) {
    vehicle function_14219d4c7d83499f(seatid);
  }
}

function function_14cc373f72a021a8(vehicleref, tagname) {
  leveldataforvehicle = vehicle_damage_getleveldataforvehicle(vehicleref);
  damagefilter = leveldataforvehicle.damageableparts[tagname].damagefilter;

  if(isDefined(damagefilter)) {
    switch (damagefilter) {
      case #"hash_519952040ad478cb":
        return &function_43c057baaca777a5;
    }
  }

  return undefined;
}

function function_2265b277a0dad0f1(vehicleref) {
  leveldataforvehicle = vehicle_damage_getleveldataforvehicle(vehicleref);
  return leveldataforvehicle.damageableparts;
}

function function_f7df41d3ad15dca8(vehicleref, tagname) {
  leveldataforvehicle = vehicle_damage_getleveldataforvehicle(vehicleref);
  return leveldataforvehicle.damageableparts[tagname].scriptablepartname;
}

function function_bad6c0e32ff1e092(vehicleref, tagname) {
  leveldataforvehicle = vehicle_damage_getleveldataforvehicle(vehicleref);
  return leveldataforvehicle.damageableparts[tagname].var_b4fccc158c681073;
}

function function_dde06c2157ec8895(vehicleref, tagname) {
  leveldataforvehicle = vehicle_damage_getleveldataforvehicle(vehicleref);
  return leveldataforvehicle.damageableparts[tagname].var_1c60586652067d4c;
}

function function_8a0e1b95abc01e56(vehicleref, tagname) {
  leveldataforvehicle = vehicle_damage_getleveldataforvehicle(vehicleref);
  return default_to(leveldataforvehicle.damageableparts[tagname].var_f0b290e6673ef286, 30);
}

function function_3df56ded0597eb6e(vehicleref, tagname) {
  leveldataforvehicle = vehicle_damage_getleveldataforvehicle(vehicleref);
  return istrue(leveldataforvehicle.damageableparts[tagname].var_9983055e997835be);
}

function function_c9f618f05861c2c5(vehicleref, tagname) {
  leveldataforvehicle = vehicle_damage_getleveldataforvehicle(vehicleref);
  reduction = leveldataforvehicle.damageableparts[tagname].damagereduction;

  if(!isDefined(reduction)) {
    reduction = 0;
  }

  return reduction;
}

function function_82cad97b4499e421(vehicle, tagname, reactivearmorexplosion) {
  data = function_29b4292c92443328(vehicle function_d93ec4635290febd());
  damageablepartdata = data.damage.damageableparts[tagname];

  if(istrue(reactivearmorexplosion)) {
    return "reactive_armor_explosion";
  }

  if(!vehicle isvehiclehusk() && isDefined(damageablepartdata.wheelref) && damageablepartdata.wheelref != "not_a_wheel" && istrue(level.var_ec75ca2494d74dab)) {
    return "death_usable";
  }

  return "death";
}

function function_9c23735bf7534afa(vehicle, damage, point, radius) {
  if(!isDefined(vehicle) || !isDefined(vehicle.damageableparts) || vehicle.damageableparts.size == 0) {
    return;
  }

  ref = vehicle function_d93ec4635290febd();
  expdamageradiussq = function_90b374d856d14373(ref);
  damageablepartdata = function_2265b277a0dad0f1(ref);
  radiussquared = radius * radius;
  var_1763b6cd86ff52f2 = undefined;
  var_6aaeea4a5b05a723 = undefined;
  var_21528cf722158315 = undefined;

  foreach(tagname, healthdata in vehicle.damageableparts) {
    if(vehicle tagexists(tagname) && istrue(damageablepartdata[tagname].var_30beabb585e60744)) {
      var_c88d34bee5a69c56 = distancesquared(point, vehicle gettagorigin(tagname));

      if(var_c88d34bee5a69c56 <= radiussquared && function_6e87d9e8601d9029(vehicle, tagname) && (!isDefined(var_1763b6cd86ff52f2) || var_c88d34bee5a69c56 < var_1763b6cd86ff52f2)) {
        var_1763b6cd86ff52f2 = var_c88d34bee5a69c56;
        var_6aaeea4a5b05a723 = tagname;
        var_21528cf722158315 = healthdata;
      }
    }
  }

  if(isDefined(var_6aaeea4a5b05a723) && isDefined(var_21528cf722158315)) {
    var_21528cf722158315.healthvalue = max(0, var_21528cf722158315.healthvalue - damage);

    if(function_853c0063f08b55e1(var_21528cf722158315)) {
      function_77db32aa48a42a76(vehicle, var_6aaeea4a5b05a723);
    }
  }
}

function function_ecdf1217e332c7d7(vehicle, damage, point, wheelstodamage) {
  if(!isDefined(vehicle) || !isDefined(vehicle.damageableparts) || vehicle.damageableparts.size == 0 || wheelstodamage == 0) {
    return;
  }

  ref = vehicle function_d93ec4635290febd();
  damageablepartdata = function_2265b277a0dad0f1(ref);
  wheels = [];

  foreach(tagname, healthdata in vehicle.damageableparts) {
    if(!vehicle tagexists(tagname) || !isDefined(damageablepartdata[tagname].wheelref) || !isDefined(vehicle.damageableparts[tagname]) || function_853c0063f08b55e1(vehicle.damageableparts[tagname])) {
      continue;
    }

    wheeldata = spawnStruct();
    wheeldata.origin = vehicle gettagorigin(tagname);
    wheeldata.tag = tagname;
    wheeldata.data = healthdata;
    wheels[wheels.size] = wheeldata;
  }

  if(wheels.size == 0) {
    return;
  }

  foreach(wheel in sortbydistance(wheels, point)) {
    wheel.data.healthvalue = max(0, wheel.data.healthvalue - damage);

    if(function_853c0063f08b55e1(wheel.data)) {
      function_77db32aa48a42a76(vehicle, wheel.tag);
    }

    wheelstodamage -= 1;

    if(wheelstodamage <= 0) {
      return;
    }
  }
}

function function_786c7ec25aad5005(vehicle, damagedata) {
  tagnames = [];
  tagdistances = [];

  if(isDefined(damagedata.partname) && isstring(damagedata.partname) && damagedata.partname != "" && vehicle tagexists(damagedata.partname)) {
    tagnames[damagedata.partname] = damagedata.partname;
  }

  if(isDefined(damagedata.attachtagname) && isstring(damagedata.attachtagname) && damagedata.attachtagname != "" && vehicle tagexists(damagedata.attachtagname)) {
    tagnames[damagedata.attachtagname] = damagedata.attachtagname;
  }

  foreach(tag in tagnames) {
    tagdistances[tag] = distancesquared(damagedata.point, vehicle gettagorigin(tag));
  }

  if(isDefined(vehicle.damageableparts) && vehicle.damageableparts.size > 0 && isexplosivedamagemod(damagedata.meansofdeath)) {
    data = vehicle_damage_getleveldataforvehicle(vehicle function_d93ec4635290febd());
    expdamageradiussq = data.expdamageradiussq;
    var_2f51e76299064178 = data.var_3259f2f4faf8eaa8;

    foreach(tagname, healthvalue in vehicle.damageableparts) {
      if(vehicle tagexists(tagname) && !function_853c0063f08b55e1(healthvalue) && !isDefined(tagnames[tagname])) {
        distancesq = distancesquared(damagedata.point, vehicle gettagorigin(tagname));

        if(distancesq <= expdamageradiussq) {
          tagnames[tagname] = tagname;
          tagdistances[tagname] = distancesq;
        }
      }
    }

    if(isDefined(var_2f51e76299064178) && tagdistances.size > var_2f51e76299064178) {
      closesttagnames = [];

      for(i = 0; i < var_2f51e76299064178; i++) {
        closest = undefined;
        closestdistance = undefined;

        foreach(tagname, tagdistance in tagdistances) {
          if(!isDefined(closestdistance) || tagdistance < closestdistance) {
            closestdistance = tagdistance;
            closest = tagname;
          }
        }

        if(isDefined(closest)) {
          closesttagnames[i] = closest;
          tagdistances[closest] = undefined;
          continue;
        }

        return closesttagnames;
      }

      return closesttagnames;
    }
  }

  return tagnames;
}

function function_7a5070220fc8ce9e(vehicleref, damageableparts) {
  huskdamageableparts = function_32b9b5d07bb56c31(vehicleref);
  var_dfdbcc779477d31c = [];

  foreach(tag, part in huskdamageableparts) {
    if(istrue(part.inactive)) {
      continue;
    }

    if(isDefined(damageableparts[tag])) {
      var_dfdbcc779477d31c[tag] = damageableparts[tag];
      continue;
    }

    var_1c09c3e40955f379 = spawnStruct();
    var_1c09c3e40955f379.healthvalue = part.healthvalue;
    var_1c09c3e40955f379.explosivedamagehealthvalue = part.explosivedamagehealthvalue;
    var_dfdbcc779477d31c[tag] = var_1c09c3e40955f379;
  }

  return var_dfdbcc779477d31c;
}

function function_cf63db12f07abf78(vehicleref, damageableparts) {
  if(!isDefined(damageableparts)) {
    return;
  }

  foreach(tagname, var_1c09c3e40955f379 in damageableparts) {
    if(function_600ff5df9dbf294(vehicleref, tagname, var_1c09c3e40955f379)) {
      var_1c09c3e40955f379.healthvalue = 0;
      function_66ac97eba6b35b4a(self, tagname, undefined);
      continue;
    }

    if(function_e531ad775dcbca22(vehicleref, tagname, var_1c09c3e40955f379)) {
      var_1c09c3e40955f379.healthvalue = 0;
      function_77db32aa48a42a76(self, tagname, undefined);
    }
  }
}

function function_e531ad775dcbca22(vehicleref, parttag, healthvalues) {
  destructionchance = function_8a0e1b95abc01e56(vehicleref, parttag);
  return randomint(100) < destructionchance;
}

function function_600ff5df9dbf294(vehicleref, parttag, healthvalues) {
  return function_3df56ded0597eb6e(vehicleref, parttag) || function_853c0063f08b55e1(healthvalues);
}

function function_853c0063f08b55e1(var_1c09c3e40955f379) {
  return var_1c09c3e40955f379.healthvalue == 0 || var_1c09c3e40955f379.explosivedamagehealthvalue == 0;
}

function function_90b374d856d14373(vehicleref) {
  leveldataforvehicle = vehicle_damage_getleveldataforvehicle(vehicleref);
  return leveldataforvehicle.expdamageradiussq;
}

function function_43c057baaca777a5(damagedata) {
  return isexplosivedamagemod(damagedata.meansofdeath);
}

function vehicle_damage_beginburndown(data) {
  self endon("death");
  self endon("end_burn_down");
  ref = function_d93ec4635290febd();

  if(!istrue(self.burningdown)) {
    leveldataforvehicle = vehicle_getleveldataforvehicle(ref);
    burndowntime = vehicle_damage_getburndowntime(ref);

    if(isDefined(burndowntime)) {
      self.burningdown = 1;

      if(isDefined(data)) {
        if(isDefined(data.attacker)) {
          self.burndownattacker = data.attacker;
        } else {
          self.burndownattacker = undefined;
        }

        if(isDefined(data.objweapon)) {
          self.burndownweapon = data.objweapon;
        } else {
          self.burndownweapon = undefined;
        }

        if(isDefined(data.attacker)) {
          assertex(isDefined(data.objweapon), "<dev string:x124>");
          assertex(isDefined(data.objweapon) && isDefined(data.objweapon.basename), "<dev string:x17c>");
        }
      }

      occupants = scripts\cp_mp\vehicles\vehicle_occupancy::function_efa75aa7f0a1289(self, 0);

      if(isDefined(occupants)) {
        scripts\cp_mp\utility\vehicle_omnvar_utility::vehomn_showwarning("burningDown", occupants, ref);
      }

      if(issharedfuncdefined(ref, "beginBurnDown")) {
        [[getsharedfunc(ref, "beginBurnDown")]]();
      }

      childthread function_43536e2e28cc20c0(data, burndowntime);
      wait burndowntime;
      self.burningdown = undefined;
      scripts\cp_mp\pet_watch::checkcarpuncherprogressgeneric();
      thread vehicle_explode(data, 0);
      return;
    }
  }
}

function function_43536e2e28cc20c0(data, burndowntime) {
  remaininghealth = self.health;

  if(isDefined(data) && isDefined(data.damage)) {
    remaininghealth = self.health - data.damage;
  }

  var_ec2b154791158e97 = int(ceil(burndowntime / 1));
  var_76e563db5d11a0ea = int(ceil(remaininghealth / var_ec2b154791158e97 / 0.25));

  for(i = 0; i < var_ec2b154791158e97; i++) {
    wait 1;
    self dodamage(var_76e563db5d11a0ea, self.origin);
    function_9542eac6997b9060(self);
  }
}

function vehicle_damage_endburndown(fromdeath) {
  if(!istrue(self.burningdown)) {
    return;
  }

  self notify("end_burn_down");
  scripts\cp_mp\pet_watch::checkcarpuncherprogressgeneric();

  if(!istrue(fromdeath)) {
    occupants = scripts\cp_mp\vehicles\vehicle_occupancy::function_efa75aa7f0a1289(self, 0);

    if(isDefined(occupants)) {
      scripts\cp_mp\utility\vehicle_omnvar_utility::vehomn_hidewarning("burningDown", occupants, function_d93ec4635290febd());
    }
  }

  self.burningdown = undefined;
}

function vehicle_damage_isburningdown() {
  return istrue(self.burningdown);
}

function vehicle_damage_getburndowntime(vehicleref) {
  if(isDefined(self.burndowntime)) {
    return self.burndowntime;
  }

  leveldata = vehicle_damage_getleveldata();
  leveldataforvehicle = vehicle_damage_getleveldataforvehicle(vehicleref);
  burndowntime = leveldataforvehicle.burndowntime;

  if(!isDefined(burndowntime)) {
    burndowntime = leveldata.burndowntime;
  }

  if(!isDefined(burndowntime) || burndowntime <= 0) {
    return undefined;
  }

  return burndowntime;
}

function vehicle_damage_shouldskipburndown(data) {
  vehiclename = function_d93ec4635290febd();
  leveldataforvehicle = vehicle_damage_getleveldataforvehicle(vehiclename, undefined, 1);

  if(isDefined(leveldataforvehicle)) {
    if(istrue(leveldataforvehicle.skipburndown)) {
      return 1;
    }
  }

  if(!isDefined(data)) {
    return 0;
  }

  if(isDefined(data.meansofdeath)) {
    if(!isexplosivedamagemod(data.meansofdeath) && data.meansofdeath != "MOD_FIRE") {
      return 0;
    }

    if(data.meansofdeath == "MOD_CRUSH") {
      return 1;
    }
  }

  if(isDefined(data.objweapon) && !isnullweapon(data.objweapon) && isDefined(function_d93ec4635290febd())) {
    shouldskipburndown = undefined;
    weaponname = data.objweapon.basename;
    leveldata = vehicle_damage_getleveldata();
    table = leveldata.table;

    if(isDefined(leveldata.table.skipburndownforvehicle[vehiclename])) {
      shouldskipburndown = leveldata.table.skipburndownforvehicle[vehiclename][weaponname];
    }

    if(isDefined(shouldskipburndown)) {
      return shouldskipburndown;
    }

    if(isDefined(leveldataforvehicle)) {
      classname = leveldataforvehicle.class;

      if(!isDefined(classname) || classname == "none") {
        return 1;
      }

      if(isDefined(leveldata.table.skipburndownforclass[classname])) {
        shouldskipburndown = leveldata.table.skipburndownforclass[classname][weaponname];
      }

      if(isDefined(shouldskipburndown)) {
        return shouldskipburndown;
      }
    } else {
      return 1;
    }
  } else {
    return 1;
  }

  return 0;
}

function function_7aaa7ae503292f43(vehicleref) {
  return vehicle_getleveldataforvehicle(vehicleref).weapon;
}

function function_6c17abf5c5d88ca(vehicleref) {
  data = vehicle_getleveldataforvehicle(vehicleref);
  return ter_op(isDefined(data.husk.weapon), data.husk.weapon, data.weapon);
}

function function_d0df49de517ded03() {
  ref = function_d93ec4635290febd();
  data = function_29b4292c92443328(ref);
  ishusk = isvehiclehusk();
  explosiondata = ter_op(ishusk || istrue(self.dontspawnhusk) && isDefined(data.huskexplosion), data.huskexplosion, data.pristineexplosion);
  weaponstring = ter_op(ishusk, function_6c17abf5c5d88ca(ref), function_7aaa7ae503292f43(ref));
  mtx = self.mtx;
  waittillframeend();
  assertex(isDefined(explosiondata), "vehicle_damage_explode: Didn't find explosion data. Either vehicle_damage_initVehicle wasn't called or there's no data for this vehicle in vehicleexplosion.csv");
  explosionposition = self gettagorigin(explosiondata.tag);
  damageposition = explosionposition;

  if(isDefined(explosiondata.damageoffset)) {
    damageposition += rotatevector((default_to(explosiondata.damageoffset.x, 0), default_to(explosiondata.damageoffset.y, 0), default_to(explosiondata.damageoffset.z, 0)), self.angles);
  }

  attacker = ter_op(isDefined(self.burndownattacker), self.burndownattacker, self);
  self radiusdamage(damageposition, explosiondata.radius, explosiondata.maxdamage, explosiondata.mindamage, attacker, "MOD_EXPLOSIVE", weaponstring);
  fxname = self.vehiclename + "_explosion";

  if(fxexists(fxname)) {
    playFX(getfx(fxname), explosionposition, anglesToForward(self.angles), anglestoup(self.angles));
  }

  if(isDefined(explosiondata.sfx)) {
    playsoundatpos(explosionposition, explosiondata.sfx);
  }

  self stopsounds();

  if(isDefined(explosiondata.scriptable)) {
    explosionscriptable = spawn("script_model", explosionposition);
    explosionscriptable setModel(explosiondata.scriptable);

    if(isDefined(mtx) && isDefined(mtx.var_c3606975ab404c5c) && mtx.var_c3606975ab404c5c != "" && explosionscriptable getscriptableparthasstate("explosion", mtx.var_c3606975ab404c5c)) {
      explosionscriptable setscriptablepartstate("explosion", mtx.var_c3606975ab404c5c);
    } else {
      explosionscriptable setscriptablepartstate("explosion", "on");
    }

    explosionscriptable.angles = self.angles;
    explosionscriptable thread function_7d040e8b44f42b5f();
  }

  if(isDefined(explosiondata.earthquakescale) && explosiondata.earthquakescale > 0) {
    earthquake(explosiondata.earthquakescale, explosiondata.earthquakeduration, explosionposition, explosiondata.earthquakeradius);
  }

  playrumbleonposition("grenade_rumble", explosionposition);
  physicsexplosionsphere(explosionposition, explosiondata.physicsouterradius, explosiondata.physicsinnerradius, explosiondata.physicsscale);
}

function function_7d040e8b44f42b5f() {
  wait 7;
  self delete();
}

function function_734926fcdbad1fd4() {
  if(scripts\cp_mp\vehicles\vehicle::isvehiclehusk()) {
    return 0;
  }

  return 1;
}

function vehicle_damage_onenterstateheavyscore(oldstateref, data) {
  if(isDefined(data) && isDefined(data.attacker)) {
    leveldataforvehicle = vehicle_damage_getleveldataforvehicle(function_d93ec4635290febd(), undefined, 1);

    if(isDefined(leveldataforvehicle)) {
      instancedataforvehicle = vehicle_damage_getinstancedataforvehicle(self, undefined, 1);
      scoreevent = undefined;
      var_8d930baa3b013616 = undefined;
      award = undefined;
      awardlaunchonly = undefined;

      if(isDefined(instancedataforvehicle)) {
        scoreevent = instancedataforvehicle.heavydamagescoreevent;
        var_8d930baa3b013616 = instancedataforvehicle.heavydamagescorelaunchonly;
        award = instancedataforvehicle.heavydamageaward;
        awardlaunchonly = instancedataforvehicle.heavydamageawardlaunchonly;
      }

      if(isDefined(leveldataforvehicle.class)) {
        if(!isDefined(scoreevent)) {
          switch (leveldataforvehicle.class) {
            case #"hash_d2a55c7ac538641b":
            case #"hash_d582c3286e5c390f":
              scoreevent = #"hash_f9162cf6b4695651";
              break;
            case #"hash_21622ca3ad06efb5":
            case #"hash_53e0b558455f04c6":
            case #"hash_c71b112fe04823d6":
              scoreevent = #"hash_8d625b12eb84e958";
              break;
            case #"hash_2453c9ffec9f5c20":
            case #"hash_e8ec392f4f2724e4":
              scoreevent = #"hash_cf6baa13dac1910a";
              break;
          }
        }

        if(isDefined(award)) {}
      }

      if(isDefined(scoreevent) && scoreevent == #"none") {
        scoreevent = undefined;
      }

      if(isDefined(award) && award == "none") {
        award = undefined;
      }

      if(!istrue(data.givepointsandxp) && isPlayer(data.attacker)) {
        data.givepointsandxp = scripts\cp_mp\vehicles\vehicle::vehicle_isenemytoplayer(self, data.attacker);
      }

      if(isDefined(data.objweapon) && weaponclass(data.objweapon.basename) != "rocketlauncher") {
        if(istrue(var_8d930baa3b013616)) {
          data.scoreeventnoweaponxp = 1;
        }

        if(istrue(awardlaunchonly)) {
          data.awardnoweaponxp = 1;
        }
      }

      data.attacker thread vehicle_damage_givescoreandxpatframeend(scoreevent, award, data, self);
    }
  }
}

function vehicle_damage_ondeathscore(data) {
  if(isDefined(data) && isDefined(data.attacker)) {
    leveldataforvehicle = vehicle_damage_getleveldataforvehicle(function_d93ec4635290febd(), undefined, 1);

    if(isDefined(leveldataforvehicle)) {
      instancedataforvehicle = vehicle_damage_getinstancedataforvehicle(self, undefined, 1);
      scoreevent = undefined;
      var_8d930baa3b013616 = undefined;
      award = undefined;
      awardlaunchonly = undefined;

      if(isDefined(instancedataforvehicle)) {
        scoreevent = instancedataforvehicle.destroyscoreevent;
        var_8d930baa3b013616 = instancedataforvehicle.destroyscorelaunchonly;
        award = instancedataforvehicle.destroyaward;
        awardlaunchonly = instancedataforvehicle.destroyawardlaunchonly;
      }

      if(isDefined(leveldataforvehicle.class)) {
        if(!isDefined(scoreevent)) {
          switch (leveldataforvehicle.class) {
            case #"hash_d2a55c7ac538641b":
            case #"hash_d582c3286e5c390f":
              scoreevent = #"hash_838cff6819237d00";
              break;
            case #"hash_21622ca3ad06efb5":
            case #"hash_53e0b558455f04c6":
            case #"hash_c71b112fe04823d6":
              scoreevent = #"hash_f82e57f24f4a4993";
              break;
            case #"hash_2453c9ffec9f5c20":
            case #"hash_e8ec392f4f2724e4":
              scoreevent = #"hash_d4032a806beebc83";
              break;
            default:
              scoreevent = #"none";
              break;
          }
        }

        if(isDefined(award)) {}
      }

      if(isDefined(scoreevent) && scoreevent == #"none") {
        scoreevent = undefined;
      }

      if(isDefined(award) && award == "none") {
        award = undefined;
      }

      if(isPlayer(data.attacker)) {
        if(!isDefined(data.givepointsandxp)) {
          data.givepointsandxp = scripts\cp_mp\vehicles\vehicle::vehicle_isenemytoplayer(self, data.attacker);
        } else if(data.givepointsandxp && scripts\cp_mp\vehicles\vehicle::vehicle_isfriendlytoplayer(self, data.attacker)) {
          data.givepointsandxp = 0;
        } else if(!data.givepointsandxp && scripts\cp_mp\vehicles\vehicle::vehicle_isenemytoplayer(self, data.attacker)) {
          data.givepointsandxp = 1;
        }
      } else {
        data.givepointsandxp = 0;
      }

      if(isDefined(data.objweapon) && weaponclass(data.objweapon.basename) != "rocketlauncher") {
        if(istrue(var_8d930baa3b013616)) {
          data.scoreeventnoweaponxp = 1;
        }

        if(istrue(awardlaunchonly)) {
          data.awardnoweaponxp = 1;
        }
      }

      if(issharedfuncdefined("challenges", "onVehicleKilled")) {
        data.attacker thread[[getsharedfunc("challenges", "onVehicleKilled")]](self, data.attacker, data.damage, data.objweapon);
      }

      data.attacker vehicle_damage_givescoreandxp(scoreevent, award, data, self getentitynumber());
    }
  }
}

function vehicle_damage_givescoreandxpatframeend(scoreevent, award, data, vehicle) {
  vehentnum = vehicle getentitynumber();
  self endon("disconnect");
  self endon("vehicle_damage_giveScoreAndXP" + vehentnum);
  waittillframeend();
  thread vehicle_damage_givescoreandxp(scoreevent, award, data, vehentnum);
}

function vehicle_damage_givescoreandxp(scoreevent, award, data, vehentnum) {
  self notify("vehicle_damage_giveScoreAndXP" + vehentnum);

  if(isDefined(scoreevent) && issharedfuncdefined("vehicle_damage", "giveScore")) {
    objweapon = ter_op(istrue(data.scoreeventnoweaponxp), undefined, data.objweapon);
    self[[getsharedfunc("vehicle_damage", "giveScore")]](scoreevent, objweapon, !istrue(data.givepointsandxp));
  }

  if(isDefined(award) && issharedfuncdefined("vehicle_damage", "giveAward")) {
    objweapon = ter_op(istrue(data.awardnoweaponxp), undefined, data.objweapon);
    self[[getsharedfunc("vehicle_damage", "giveAward")]](award, objweapon, !istrue(data.givepointsandxp));
  }
}

function vehicle_damage_setweaponclassmoddamageforvehicle(weaponclass, mod, var_21e99fcec7e19345, vehicleref) {
  if(issharedfuncdefined("vehicle_damage", "setWeaponClassModDamageForVehicle")) {
    [[getsharedfunc("vehicle_damage", "setWeaponClassModDamageForVehicle")]](weaponclass, mod, var_21e99fcec7e19345, vehicleref);
  }
}

function vehicle_damage_setperkmoddamage(ref, mod, var_21e99fcec7e19345) {
  if(issharedfuncdefined("vehicle_damage", "setPerkModDamage")) {
    [[getsharedfunc("vehicle_damage", "setPerkModDamage")]](ref, mod, var_21e99fcec7e19345);
  }
}

function vehicle_damage_setweaponhitdamagedata(weaponref, hitsperattack) {
  if(issharedfuncdefined("vehicle_damage", "setWeaponHitDamageData")) {
    [[getsharedfunc("vehicle_damage", "setWeaponHitDamageData")]](weaponref, hitsperattack);
  }
}

function vehicle_damage_setvehiclehitdamagedata(vehicleref, hitstokill) {
  if(issharedfuncdefined("vehicle_damage", "setVehicleHitDamageData")) {
    [[getsharedfunc("vehicle_damage", "setVehicleHitDamageData")]](vehicleref, hitstokill);
  }
}

function vehicle_damage_setvehiclehitdamagedataforweapon(vehicleref, hitstokill, weaponref) {
  if(issharedfuncdefined("vehicle_damage", "setVehicleHitDamageDataForWeapon")) {
    [[getsharedfunc("vehicle_damage", "setVehicleHitDamageDataForWeapon")]](vehicleref, hitstokill, weaponref);
  }
}

function vehicle_damage_setweaponhitdamagedataforvehicle(weaponref, hitsperattack, vehicleref) {
  if(issharedfuncdefined("vehicle_damage", "setWeaponHitDamageDataForVehicle")) {
    [[getsharedfunc("vehicle_damage", "setWeaponHitDamageDataForVehicle")]](weaponref, hitsperattack, vehicleref);
  }
}

function vehicle_damage_setpremoddamagecallback(vehicleref, callback) {
  if(issharedfuncdefined("vehicle_damage", "setPreModDamageCallback")) {
    [[getsharedfunc("vehicle_damage", "setPreModDamageCallback")]](vehicleref, callback);
  }
}

function vehicle_damage_setpostmoddamagecallback(vehicleref, callback) {
  if(issharedfuncdefined("vehicle_damage", "setPostModDamageCallback")) {
    [[getsharedfunc("vehicle_damage", "setPostModDamageCallback")]](vehicleref, callback);
  }
}

function vehicle_damage_setdeathcallback(vehicleref, callback) {
  if(issharedfuncdefined("vehicle_damage", "setDeathCallback")) {
    [[getsharedfunc("vehicle_damage", "setDeathCallback")]](vehicleref, callback);
  }
}

function function_e5cde837844c6112(vehicleref, seatid, damagescale) {
  leveldataforvehicle = vehicle_damage_getleveldataforvehicle(vehicleref, 1);

  if(!isDefined(leveldataforvehicle.occupantdamagescale)) {
    leveldataforvehicle.occupantdamagescale = [];
  }

  leveldataforvehicle.occupantdamagescale[seatid] = damagescale;
}

function function_42b7542e79da627f(vehicleref, seatid, damageclamp) {
  leveldataforvehicle = vehicle_damage_getleveldataforvehicle(vehicleref, 1);

  if(!isDefined(leveldataforvehicle.occupantdamageclamp)) {
    leveldataforvehicle.occupantdamageclamp = [];
  }

  leveldataforvehicle.occupantdamageclamp[seatid] = damageclamp;
}

function vehicle_damage_initdebug() {
  setdvarifuninitialized(@ "hash_32ee2ef39806b3b9", 0);
  setdvarifuninitialized(@ "hash_4827ebae75561872", 0);

  thread function_cc07937f89e8a007();
}

function function_cc07937f89e8a007() {
  level.vehiclegod = getdvarint(@ "hash_32ee2ef39806b3b9", 0) > 0;

  while(true) {
    simulatedamagepercent = getdvarint(@ "hash_4827ebae75561872", 0);

    if(simulatedamagepercent > 0) {
      vehicles = scripts\cp_mp\vehicles\vehicle_tracking::vehicle_tracking_getgameinstancesforall();

      if(vehicles.size > 0) {
        iprintln("<dev string:x1f2>" + simulatedamagepercent + "<dev string:x1f4>");
      }

      foreach(vehicle in vehicles) {
        if(isDefined(vehicle) && !vehicle scripts\cp_mp\vehicles\vehicle::isvehicledestroyed()) {
          function_a4e5dc47d7128f1d(vehicle, simulatedamagepercent);
        }
      }

      setdevdvar(@ "hash_4827ebae75561872", 0);
    }

    vehiclegod = getdvarint(@ "hash_32ee2ef39806b3b9", 0) > 0;

    if(level.vehiclegod != vehiclegod) {
      if(vehiclegod) {
        iprintln("<dev string:x20b>");
      } else {
        iprintln("<dev string:x21a>");
      }

      level.vehiclegod = vehiclegod;
    }

    waitframe();
  }
}

function function_a4e5dc47d7128f1d(vehicle, percent) {
  damagedata = spawnStruct();
  attacker = level.players[0];
  percent = min(percent, 100) / 100;
  damage = int(min(vehicle.health, ceil(vehicle.maxhealth * percent)));
  thread function_28c5e9f1993854aa();
  vehicle dodamage(damage, vehicle.origin, attacker, undefined, "<dev string:x22a>");
  thread function_a6106f4cf6a1233();
}

function function_28c5e9f1993854aa() {
  level notify("<dev string:x238>");
  level endon("<dev string:x238>");

  if(!isDefined(level.vehiclefriendlydamageold)) {
    level.vehiclefriendlydamageold = istrue(level.vehiclefriendlydamage);
    level.vehiclefriendlydamage = 1;
  }

  waittillframeend();
  thread function_a6106f4cf6a1233();
}

function function_a6106f4cf6a1233() {
  level notify("<dev string:x238>");

  if(isDefined(level.vehiclefriendlydamageold)) {
    level.vehiclefriendlydamage = level.vehiclefriendlydamageold;
    level.vehiclefriendlydamageold = undefined;
  }
}

# /