/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: hashed\script_40f967ad5d18ea74.gsc
***********************************************/

#using script_164a456ce05c3483;
#using script_17dcb1172e441bf6;
#using script_1a9763988299e68d;
#using script_1b01e95a6b5270fd;
#using script_1b0b07ff57d1dde3;
#using script_1ce46999727f2f2b;
#using script_1ee011cd0961afd7;
#using script_2a5bf5b4a00cee0d;
#using script_40f967ad5d18ea74;
#using script_47851dbeea22fe66;
#using script_4d748e58ce25b60c;
#using script_5701633066d199f2;
#using script_5f20d3b434d24884;
#using script_68cdf0ca5df5e;
#using script_74a56359b7d02ab6;
#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\math_shared;
#using scripts\core_common\spawner_shared;
#using scripts\core_common\spawning_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#namespace namespace_c85a46fe;
class class_6fd989ce {
  var m_health;
  var m_name;
  var var_1ac7d2e7;
  var var_2d1aa65b;
  var var_5466886f;
  var var_6b6ff268;
  var var_85613d6b;
  var var_da2586f5;

  constructor() {
    m_name = "";
    var_5466886f = "";
    var_2d1aa65b = 512;
    var_1ac7d2e7 = 256;
    var_da2586f5 = 15;
    var_85613d6b = [];
    m_health = 12000;
    var_6b6ff268 = 1;
  }

  function function_1296c737() {
    return var_da2586f5;
  }

  function getname() {
    return m_name;
  }

  function function_6b86128a() {
    return var_6b6ff268;
  }

  function getheight() {
    return var_1ac7d2e7;
  }

  function function_910a1ed9() {
    return var_85613d6b;
  }

  function init(var_d7dae20a) {
    m_name = var_d7dae20a.script_noteworthy;
    assert(isDefined(m_name) && m_name != "<dev string:x38>", "<dev string:x3c>");
    a_toks = strtok(var_d7dae20a.script_string, ",");
    assert(a_toks.size >= 3, "<dev string:x77>" + var_d7dae20a.script_string);
    var_5466886f = a_toks[0];
    var_2d1aa65b = int(a_toks[1]);
    var_1ac7d2e7 = int(a_toks[2]);

    if(a_toks.size >= 4) {
      var_da2586f5 = int(a_toks[3]);
    }

    if(a_toks.size >= 5) {
      m_health = int(a_toks[4]);

      if(!isDefined(m_health)) {
        m_health = 12000;
      }
    }

    if(a_toks.size >= 6) {
      var_6b6ff268 = int(a_toks[5]);
    }

    var_85613d6b = struct::get_array(var_d7dae20a.target, "targetname");

    foreach(node in var_85613d6b) {
      node.origin -= var_d7dae20a.origin;
    }
  }

  function getwidth() {
    return var_2d1aa65b;
  }

  function function_c1009efb() {
    return var_5466886f;
  }

  function function_de9607de() {
    return m_health;
  }
}
class class_c4926dee {
  var ai_type;
  var generator;
  var health;
  var m_active;
  var m_context;
  var m_model;
  var m_type;
  var maxhealth;
  var origin;
  var takedamage;
  var team;
  var var_1d308eec;
  var var_21a4af6a;
  var var_24bb61f1;
  var var_31d445dc;
  var var_520afec4;
  var var_5eeaacc8;
  var var_6d14cf9d;
  var var_71c23335;
  var var_71fccd1d;
  var var_83cb975;
  var var_87ef4b13;
  var var_915ae41d;
  var var_a3c3a5f4;
  var var_c24010e8;
  var var_c35ec3b3;
  var var_cda957a8;
  var var_de510cda;

  constructor() {
    var_de510cda = undefined;
    var_a3c3a5f4 = undefined;
    m_model = undefined;
    var_915ae41d = 15;
    var_71c23335 = [];
    m_active = 0;
    var_31d445dc = [];
    m_type = undefined;
    var_1d308eec = "generic_generator_active";
    var_87ef4b13 = "generic_generator_die";
    var_5eeaacc8 = # "zmb_aat_kilowatt_explode";
    var_520afec4 = # "zmb_aat_kilowatt_explode";
    var_c24010e8 = 0;
    var_83cb975 = undefined;
    var_cda957a8 = undefined;
    var_c35ec3b3 = undefined;
    var_24bb61f1 = undefined;
    m_context = 1;
    var_71fccd1d = undefined;
  }

  function destructor() {
    var_31d445dc = [];
    namespace_1e25ad94::debugmsg("Generator destructor being called.");
  }

  function function_331fc68(activefx, var_3ac6a87b, spawnfx, spawnfxdelay = 1) {
    var_1d308eec = activefx;
    var_87ef4b13 = var_3ac6a87b;
    var_cda957a8 = spawnfx;
    var_24bb61f1 = spawnfxdelay;
  }

  function function_5576668(einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, var_fd90b0bb, vpoint, vdir, shitloc, psoffsettime, iboneindex, imodelindex) {
    if([[generator]] - > candamage(shitloc) == 0) {
      return 0;
    }

    if(iboneindex === # "mod_crush") {
      return 0;
    }

    if(isDefined(shitloc) && shitloc.team === team) {
      return 0;
    }

    if(is_true(level.doa.var_318aa67a) && isDefined(shitloc)) {
      distsq = distancesquared(origin, shitloc.origin);

      if(distsq > sqr(1500)) {
        return 0;
      } else if(distsq < sqr(300)) {
        psoffsettime = psoffsettime;
      } else {
        lerp = 1 - distsq / sqr(1500);
        psoffsettime = int(lerpfloat(0, psoffsettime, lerp));
      }
    }

    psoffsettime = int(psoffsettime);
    var_799e18e5 = imodelindex;
    var_5f32808d = 1;

    if(psoffsettime >= 1000) {
      var_5f32808d = 2;
    }

    self namespace_ec06fe4a::function_2f4b0f9(health, shitloc, var_799e18e5, psoffsettime, var_5f32808d);

    if(psoffsettime >= health) {
      takedamage = 0;
      psoffsettime = health - 1;

      if(isDefined(vdir)) {
        owner = isvehicle(vdir) ? vdir getvehicleowner() : isDefined(vdir.owner) ? vdir.owner : undefined;
      }

      if(isDefined(owner) && isDefined(owner.owner)) {
        owner = owner.owner;
      }

      if(isDefined(owner)) {
        shitloc = owner;
      }

      if(isPlayer(shitloc)) {
        shitloc namespace_eccff4fb::enemykill(undefined, 2500);
        xp = [[generator]] - > isactive() ? getdvarint(#"hash_68999e371537612e", 350) : getdvarint(#"hash_1a9633163aac4fab", 100);
        namespace_7f5aeb59::function_f8645db3(xp);
        level.doa.var_148272df++;
      }

      var_a49e1d80 = [[generator]] - > function_3e35eb73();

      foreach(spawner in var_a49e1d80) {
        if(isDefined(spawner)) {
          spawner notify(#"hash_38a47f8bbc000501");
        }
      }

      doa_enemy::function_f7086924(self);

      foreach(ai in [[generator]] - > function_4d5eefc7()) {
        if(!isDefined(ai)) {
          continue;
        }

        if(is_true(ai.var_1f2d0447) && gettime() - ai.doa.birthtime < 1500) {
          ai.annihilate = 1;
          ai thread namespace_ec06fe4a::function_570729f0(0.1);
        }
      }

      level thread namespace_c85a46fe::function_40ec656b(self, [[generator]] - > function_68e475d0(), [[generator]] - > function_8370e1a3());
    }

    if(isPlayer(shitloc) && var_21a4af6a > 0) {
      var_21a4af6a -= psoffsettime;
      points = int(psoffsettime / 25) * 25;
      points >>= 2;
      points = int(points / 25) * 25;
      shitloc namespace_eccff4fb::enemykill(undefined, points);
    }

    return psoffsettime;
  }

  function function_bf5fc68() {
    return var_24bb61f1;
  }

  function function_fa5c9c4() {
    return m_context == 0;
  }

  function function_3038a5ee() {
    return var_cda957a8;
  }

  function function_30a0163e() {
    return m_context == 2;
  }

  function getcenter() {
    return m_model.origin;
  }

  function function_3e35eb73() {
    return var_31d445dc;
  }

  function function_41157a40() {
    level endon(#"game_over");
    self endon(#"destroy");

    if(function_30a0163e()) {
      while(level flag::get("dungeon_building")) {
        wait 1;
      }
    }

    while(true) {
      if(!isalive()) {
        return;
      }

      last = m_active;
      m_active = 0;
      players = getplayers();

      if(function_30a0163e()) {
        room = function_7475529a();

        if(!isDefined(room)) {
          return;
        }

        foreach(player in players) {
          if(player.doa.var_2fb8ffeb === room) {
            m_active = 1;
            break;
          }

          foreach(adjacent in room.neighbors) {
            if(!isDefined(adjacent)) {
              continue;
            }

            if(player.doa.var_2fb8ffeb === adjacent) {
              m_active = 1;
              break;
            }
          }
        }
      } else {
        foreach(player in players) {
          if(player istouching(var_a3c3a5f4)) {
            m_active = 1;
            break;
          }
        }
      }

      m_active &= function_d8b78bb3();

      if(last && !m_active) {
        m_model namespace_83eb6304::turnofffx(function_45ee8bad());
        m_model clientfield::set("show_health_bar", 0);
        m_model namespace_c85a46fe::function_a5c8be46();
        doa_enemy::function_f7086924(m_model);
      } else if(!last && m_active) {
        m_model namespace_83eb6304::function_3ecfde67(function_45ee8bad());
        m_model clientfield::set("show_health_bar", 1);
        m_model namespace_c85a46fe::showonradar();

        if(isDefined(var_5eeaacc8)) {
          m_model namespace_e32bb68::function_3a59ec34(var_5eeaacc8);
        }
      }

      wait randomfloatrange(0.25, 0.75);
      arrayremovevalue(var_71c23335, undefined, 0);
    }
  }

  function function_44549c13() {
    return var_c35ec3b3;
  }

  function function_45ee8bad() {
    return var_1d308eec;
  }

  function function_4d5eefc7(ai) {
    return var_71c23335;
  }

  function gettype() {
    return m_type;
  }

  function isalive() {
    return isDefined(m_model) && m_model.health > 0;
  }

  function function_68e475d0() {
    return var_87ef4b13;
  }

  function function_7475529a() {
    return var_71fccd1d;
  }

  function function_75df0623(room) {
    var_71fccd1d = room;
  }

  function healovertime(generator, interval, var_f0fd371f = 300) {
    self endon(#"death");

    while(true) {
      wait 1;

      if([[interval]] - > isactive()) {
        continue;
      }

      if(health < maxhealth) {
        health = math::clamp(health + var_f0fd371f, 0, maxhealth);
        health = health / maxhealth * ((1 << 8) - 1);
        self clientfield::set("set_health_bar", int(health));
      }
    }
  }

  function function_7fcca25d() {
    return var_83cb975;
  }

  function function_8370e1a3() {
    return var_520afec4;
  }

  function init(origin, angles, def, width, height, maxalive, context) {
    var_de510cda = def;
    m_context = context;

    if(!isDefined(width)) {
      width = [[var_de510cda]] - > getwidth();
    }

    if(!isDefined(height)) {
      height = [[var_de510cda]] - > getheight();
    }

    if(!isDefined(maxalive)) {
      maxalive = [[var_de510cda]] - > function_1296c737();
    }

    if(!function_30a0163e()) {
      var_a3c3a5f4 = namespace_ec06fe4a::spawntrigger("trigger_radius", origin + (0, 0, -72), 2 | 16, width, height);

      if(!isDefined(var_a3c3a5f4)) {
        return;
      }
    }

    m_model = namespace_ec06fe4a::spawnmodel(origin, [[var_de510cda]] - > function_c1009efb());

    if(!isDefined(m_model)) {
      var_a3c3a5f4 delete();
      return;
    }

    m_model.modelname = [[var_de510cda]] - > function_c1009efb();
    m_model.angles = angles;
    m_model.health = [[var_de510cda]] - > function_de9607de() * getplayers().size;

    if(!isDefined(m_model.health)) {
      m_model.health = 5000;
    }

    m_model.maxhealth = m_model.health;
    m_model.var_21a4af6a = m_model.maxhealth;
    m_model.radius = width;
    m_model.generator = self;
    m_model.trigger = var_a3c3a5f4;
    m_model.takedamage = 1;
    m_model setCanDamage(1);
    m_model.var_86a21346 = &function_5576668;
    m_model setteam(#"axis");
    var_915ae41d = maxalive;
    m_model thread healovertime(self, 1);
    var_83cb975 = namespace_ec06fe4a::function_7fcca25d("Generator" + [[var_de510cda]] - > function_c1009efb());
    spawnnodes = [[var_de510cda]] - > function_910a1ed9();

    foreach(node in spawnnodes) {
      spawner = spawnStruct();
      spawner.origin = m_model.origin + rotatepoint(node.origin, m_model.angles);
      spawner.ai_type = node.script_noteworthy;

      if([[var_de510cda]] - > function_6b86128a()) {
        spawner.origin = namespace_ec06fe4a::function_65ee50ba(spawner.origin);
      }

      spawner.angles = node.angles + m_model.angles;
      spawner.var_6d14cf9d = isDefined(node.script_int) ? int(node.script_int) : 3;

      if(!isDefined(m_type) && isDefined(spawner.ai_type)) {
        m_type = spawner.ai_type;
      }

      spawner thread function_a2bbc139(self);
      var_31d445dc[var_31d445dc.size] = spawner;
    }

    m_model enableaimassist();
    m_model thread namespace_c85a46fe::function_ec072c1a(gettype());
    self thread function_41157a40();
  }

  function function_a2bbc139(generator) {
    self endon(#"hash_38a47f8bbc000501");
    generator endon(#"destroy");
    level endon(#"game_over");
    model = undefined;
    spawndef = doa_enemy::function_d7c5adee(ai_type);
    wait randomfloat(2);

    while(isDefined(generator) && [[generator]] - > isalive()) {
      if([[generator]] - > canspawn()) {
        if(!isDefined(model)) {
          model = [[generator]] - > getmodel();
          spawnfx = [[generator]] - > function_3038a5ee();
          var_36ca64f1 = [[generator]] - > function_44549c13();
        }

        if(isDefined(model) && isDefined(spawnfx)) {
          model namespace_83eb6304::function_3ecfde67(spawnfx);

          if(isDefined(var_36ca64f1)) {
            model namespace_e32bb68::function_3a59ec34(var_36ca64f1);
          }

          wait[[generator]] - > function_bf5fc68();

          if(isDefined(model)) {
            model namespace_83eb6304::turnofffx(spawnfx);
          }
        }

        doa_enemy::function_a6b807ea(spawndef, 1, origin, 0, generator);

        if(getdvarint(#"hash_14f8549e0645635d", 0)) {
          level thread namespace_1e25ad94::function_1d1f2c26(origin, var_6d14cf9d, 12, (1, 0, 0));
        }

        wait var_6d14cf9d;
        continue;
      }

      wait randomfloatrange(0.5, 2);
    }
  }

  function array_removeundefined(array) {
    removed = array;
    arrayremovevalue(removed, undefined, 1);

    foreach(obj in removed) {
      if(function_3132f113(obj)) {
        arrayremovevalue(removed, obj, 1);
      }
    }

    return removed;
  }

  function function_bbdb303e() {
    return m_context == 3;
  }

  function function_bcd1aaf5(ai) {
    var_71c23335[var_71c23335.size] = ai;
  }

  function function_c08f72c2(var_3c6b5a32, var_3ffd02d8, var_acedff5b) {
    var_5eeaacc8 = var_3c6b5a32;
    var_520afec4 = var_3ffd02d8;
    var_c35ec3b3 = var_acedff5b;
  }

  function enable(flag) {
    if(isDefined(var_a3c3a5f4)) {
      var_a3c3a5f4 triggerenable(flag);
    }
  }

  function isactive() {
    return m_active;
  }

  function destroy() {
    profilestart();
    doa_enemy::function_f7086924(m_model);
    var_c24010e8 = 1;

    foreach(ai in var_71c23335) {
      if(!isDefined(ai)) {
        continue;
      }

      if(is_true(ai.var_1f2d0447) && gettime() - ai.doa.birthtime < 1500) {
        ai.annihilate = 1;
        ai thread namespace_ec06fe4a::function_570729f0(0.1);
      }
    }

    level notify(var_83cb975);
    self notify(#"destroy");
    namespace_c85a46fe::function_320a66f9(m_model);
    profilestop();
  }

  function function_d8b78bb3() {
    if(isDefined(level.doa.var_182fb75a)) {
      if(function_30a0163e()) {
        return true;
      } else {
        return (isDefined(level.doa.var_6f3d327) && function_bbdb303e());
      }
    }

    if(isDefined(level.doa.var_6f3d327)) {
      if(function_bbdb303e()) {
        return true;
      } else {
        return false;
      }
    }

    if(isDefined(level.doa.var_a77e6349)) {
      if(function_e55669e8()) {
        return true;
      } else {
        return false;
      }
    }

    return true;
  }

  function getmodel() {
    return m_model;
  }

  function canspawn() {
    return isactive() && isalive() && var_71c23335.size < var_915ae41d && var_c24010e8 == 0 && namespace_250e9486::function_60f6a9e();
  }

  function function_e55669e8() {
    return m_context == 1;
  }

  function getradius() {
    return m_model.radius;
  }

  function function_e96aef39() {
    return var_5eeaacc8;
  }

  function candamage(attacker) {
    if(isDefined(attacker) && is_true(attacker.doa.infps)) {
      return 1;
    }

    return isactive();
  }

  function function_f4238fe4() {
    return m_context;
  }
}

function function_f1ba2302(name) {
  foreach(var_9c185dd1 in level.doa.var_ea48c46c) {
    if(name === [[var_9c185dd1]] - > getname()) {
      return var_9c185dd1;
    }
  }
}

function init() {
  clientfield::register("scriptmover", "set_icon", 1, 4, "int");
  clientfield::register("toplayer", "generator_sonar", 1, 1, "int");
  level.doa.var_ea48c46c = [];
  level.doa.var_8acd67ef = [];
  level.doa.var_148272df = 0;
  var_ea48c46c = struct::get_array("generatorDef", "targetname");

  foreach(item in var_ea48c46c) {
    if(isDefined(function_f1ba2302(item.script_noteworthy))) {
      continue;
    }

    generatordef = new class_6fd989ce();
    [[generatordef]] - > init(item);
    level.doa.var_ea48c46c[level.doa.var_ea48c46c.size] = generatordef;
  }

  level.doa.var_c3219b45 = [];
}

function function_40ec656b(model, var_3ac6a87b, var_c4a370ce) {
  model namespace_83eb6304::function_3ecfde67(var_3ac6a87b);

  if(namespace_ec06fe4a::function_a8975c67() && isDefined(var_c4a370ce) && validateorigin(model.origin)) {
    playsoundatposition(var_c4a370ce, model.origin);
  }

  util::wait_network_frame();

  if(isDefined(model)) {
    function_320a66f9(model);
  }
}

function function_320a66f9(model) {
  model clientfield::set("show_health_bar", 0);
  model function_a5c8be46();
  model namespace_ec06fe4a::function_8c808737();
  doa_enemy::function_f7086924(model);
  arrayremovevalue(level.doa.var_8acd67ef, model.generator);
  level.doa.var_c3219b45[level.doa.var_c3219b45.size] = model;
}

function function_5db81c1c() {
  self notify("5065c960434bfd9d");
  self endon("5065c960434bfd9d");
  level endon(#"game_over");

  while(true) {
    util::wait_network_frame();

    while(level.doa.var_c3219b45.size) {
      model = level.doa.var_c3219b45[0];
      arrayremoveindex(level.doa.var_c3219b45, 0);

      if(!isDefined(model)) {
        continue;
      }

      if(isDefined(model.trigger)) {
        model.trigger delete();
      }

      namespace_1e25ad94::debugmsg("Generator model delete Ent:" + model getentitynumber());
      model delete();
    }
  }
}

function function_782e605e(name) {
  generators = struct::get_array(name + "_doa_generator", "targetname");
  var_d613e783 = (getplayers().size - 1) * 10;

  foreach(item in generators) {
    var_9b3d6734 = 100;

    if(isDefined(item.script_parameters)) {
      a_toks = strtok(item.script_parameters, ",");
      radius = int(a_toks[0]);

      if(a_toks.size >= 2) {
        height = int(a_toks[1]);
      }

      if(a_toks.size >= 3) {
        maxalive = int(a_toks[2]);
      }

      if(a_toks.size >= 4) {
        var_9b3d6734 = int(a_toks[3]);
      }
    }

    var_9b3d6734 += var_d613e783;

    if(var_9b3d6734 < 100 && randomint(100) > var_9b3d6734) {
      continue;
    }

    function_4c16ce2c(item.script_noteworthy, item.origin, item.angles, radius, height, maxalive);
  }
}

function function_edfcfa44(context = 0) {
  level thread function_5db81c1c();

  if(context == 0) {
    while(level.doa.var_8acd67ef.size) {
      instance = level.doa.var_8acd67ef[0];

      if(isDefined(instance)) {
        [[instance]] - > destroy();
      }
    }

    level.doa.var_8acd67ef = [];
  } else {
    var_29287f31 = [];

    foreach(generator in level.doa.var_8acd67ef) {
      if(context == [[generator]] - > function_f4238fe4()) {
        var_29287f31[var_29287f31.size] = generator;
      }
    }

    while(var_29287f31.size) {
      instance = var_29287f31[0];
      arrayremovevalue(var_29287f31, instance);

      if(isDefined(instance)) {
        [[instance]] - > destroy();
      }
    }
  }

  while(level.doa.var_c3219b45.size > 0) {
    wait 1;
  }
}

function function_4c16ce2c(name, origin, angles, width, height, maxalive, context = 1) {
  var_9c185dd1 = function_f1ba2302(name);

  if(isDefined(var_9c185dd1)) {
    generator = new class_c4926dee();
    [[generator]] - > init(origin, angles, var_9c185dd1, width, height, maxalive, context);

    if(name == "zombie") {
      [[generator]] - > function_331fc68([[generator]] - > function_45ee8bad(), "zombie_generator_die");
    } else if(name == "crawler") {
      [[generator]] - > function_331fc68("crawler_generator_spawn", "zombie_generator_die", "crawler_generator_spawn");
    } else if(name == "skeleton") {
      [[generator]] - > function_331fc68([[generator]] - > function_45ee8bad(), "skeleton_generator_die");
    } else if(name == "demon") {
      [[generator]] - > function_331fc68([[generator]] - > function_45ee8bad(), "meat_explode");
    }

    level.doa.var_8acd67ef[level.doa.var_8acd67ef.size] = generator;
    return generator;
  }
}

function function_ec072c1a(type) {
  self endon(#"death");
  self.radartype = type;
}

function showonradar() {
  if(!isDefined(self)) {
    return;
  }

  icon_index = undefined;

  switch (self.radartype) {
    case # "basic_zombie":
      icon_index = 2;
      break;
    case # "skeleton":
      icon_index = 7;
      break;
    case # "brutus":
      icon_index = 3;
      break;
    case # "bat":
      icon_index = 4;
      break;
    case # "demon":
      icon_index = 5;
      break;
    case # "wolf_hellhound":
      icon_index = 6;
      break;
    case # "crawler_zombie":
      icon_index = 8;
      break;
  }

  if(isDefined(icon_index)) {
    self clientfield::set("set_icon", icon_index);
  }
}

function function_a5c8be46() {
  if(!isDefined(self)) {
    return;
  }

  self clientfield::set("set_icon", 0);
}

function function_47c860ff(flag) {
  if(flag) {
    self showonradar();
  } else {
    self function_a5c8be46();
  }

  if(isDefined(self.generator)) {
    [[self.generator]] - > enable(flag);
  }
}