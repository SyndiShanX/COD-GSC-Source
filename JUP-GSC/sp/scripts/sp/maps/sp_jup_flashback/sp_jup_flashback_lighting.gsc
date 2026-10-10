/*****************************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\scripts\sp\maps\sp_jup_flashback\sp_jup_flashback_lighting.gsc
*****************************************************************************/

#using scripts\common\lighting;
#using scripts\common\utility;
#using scripts\engine\sp\utility;
#using scripts\engine\utility;
#using scripts\sp\starts;
#using scripts\sp\utility;
#namespace fb_lighting;

function main() {
  level.var_bc1ebbcfcb8b1cc = 0;
  function_e11e77f687b7b626();
  function_9c946a04ddaf2d6c(level.alarm_lights);
  level.var_6d38a19a6da9bc01 = (-21.1347, -26.3083, 0);
  level.var_38a05abad5d6656b = (-25.1347, -112, 0);
  level.var_ee8a6b555302846f = level.var_6d38a19a6da9bc01;
}

function function_e11e77f687b7b626() {
  function_1d630e974680d15e();
  function_5304c669ebdedf09();
  level.var_4cd5a01344e3772c = function_829bef6070a83a91("intro_tunnel_light");
  level.var_6710405865d176f0 = function_829bef6070a83a91("dark_tunnel_light");
  level.alarm_lights = function_829bef6070a83a91("alarm_light");
}

function function_829bef6070a83a91(targetname) {
  light_list = getEntArray(targetname, "targetname");

  foreach(l in light_list) {
    l.og_intensity = l getlightintensity();
    l setlightintensity(0);
  }

  return light_list;
}

function function_feb0fab3be7205f2(light_list, intensity) {
  foreach(l in light_list) {
    l setlightintensity(intensity);
  }
}

function function_12e0aa50739e007b(light_list, frac) {
  foreach(l in light_list) {
    l setlightintensity(frac * l.og_intensity);
  }
}

function function_678ef11d2cfc2e2e() {
  setsaveddvar(@ "hash_dab366f405822e6c", 0.002);
  function_c758b824ee6d21b1(1);
  function_12e0aa50739e007b(level.var_6710405865d176f0, 1);
  function_12e0aa50739e007b(level.var_4cd5a01344e3772c, 0);

  if(flag("lighting_intro_tunnel_flag")) {
    flag_clear("lighting_intro_tunnel_flag");
  }

  flag_set("lighting_dark_tunnel_flag");
}

function function_abb1267ad3428() {
  setsaveddvar(@ "hash_dab366f405822e6c", 0.003);
  function_c758b824ee6d21b1(0);
  function_18f08f56aec273e6();
  function_12e0aa50739e007b(level.var_4cd5a01344e3772c, 1);
  function_12e0aa50739e007b(level.var_6710405865d176f0, 0);

  if(flag("lighting_dark_tunnel_flag")) {
    flag_clear("lighting_dark_tunnel_flag");
  }

  flag_set("lighting_intro_tunnel_flag");
}

function function_230ecfc530cd108a() {
  function_abb1267ad3428();
  thread function_5a765152015c6681();
  flag_wait("infil_vehicle_stop_at_gate");
  wait 2.7;
  thread function_46eb014f0b3ba202();
  visionsetnaked("sp_jup_flashback_intro_tunnels_high_exposure", 3);
  wait 10.45;
  function_1a63eead5c113374();
  visionsetnaked("sp_jup_flashback_intro_tunnels", 3.5);
  flag_wait("infil_vehicle_stopping");
  thread function_b7da49934e2d4c32();
  visionsetnaked("", 0.05);
  function_678ef11d2cfc2e2e();
}

function function_5a765152015c6681() {
  function_9985ab0a5b897efb(level.infilvehicle, "infil_veh");
  level.unique_lights["infil_veh_01"] function_f5600319797ffa1e(level.unique_lights["infil_veh_01"].og_intensity);
  level.unique_lights["infil_veh_02"] function_f5600319797ffa1e(level.unique_lights["infil_veh_02"].og_intensity);
  level.unique_lights["infil_veh_03"] function_f5600319797ffa1e(level.unique_lights["infil_veh_03"].og_intensity);
  level.unique_lights["infil_veh_04"] function_f5600319797ffa1e(level.unique_lights["infil_veh_04"].og_intensity);
}

function function_46eb014f0b3ba202() {
  setsaveddvar(@ "hash_8667c0bb90c5bfc3", "1500");
  function_67d35fd53f94e241("infil_veh");
  level.unique_lights["infil_veh_01"] thread function_70a9f70afd49dead(level.unique_lights["infil_veh_01"].og_intensity, 0, 3);
  level.unique_lights["infil_veh_02"] thread function_70a9f70afd49dead(level.unique_lights["infil_veh_02"].og_intensity, 0, 3);
  level.unique_lights["infil_veh_03"] thread function_70a9f70afd49dead(level.unique_lights["infil_veh_03"].og_intensity, 0, 3);
  level.unique_lights["infil_veh_04"] thread function_70a9f70afd49dead(level.unique_lights["infil_veh_04"].og_intensity, 0, 3);
}

function function_b7da49934e2d4c32() {}

function function_403b8070ead43a7() {
  if(starts::is_after_start("infil_garage")) {
    function_678ef11d2cfc2e2e();
    return;
  }

  function_abb1267ad3428();
  function_9985ab0a5b897efb(level.infilvehicle, "infil_veh");
  thread function_46eb014f0b3ba202();
  visionsetnaked("sp_jup_flashback_intro_tunnels_high_exposure", 3);
  wait 10.45;
  visionsetnaked("sp_jup_flashback_intro_tunnels", 3.5);
  flag_wait("infil_vehicle_stopping");
  function_b7da49934e2d4c32();
  visionsetnaked("", 0.05);
  function_678ef11d2cfc2e2e();
}

function count_down_thread() {
  self notify("count_down_thread");
  self endon("count_down_thread");
  t = 0;

  while(true) {
    printtoscreen2d(500, 500, t);

    t += 0.05;
    wait 0.05;
  }
}

function function_c758b824ee6d21b1(var_ba5d5068ba9fdd0f) {
  if(var_ba5d5068ba9fdd0f == level.var_bc1ebbcfcb8b1cc) {
    return;
  }

  while(gettime() < 500) {
    waitframe();
  }

  visionsetalternate(var_ba5d5068ba9fdd0f, 0.05);
  level.var_bc1ebbcfcb8b1cc = var_ba5d5068ba9fdd0f;
}

function function_18f08f56aec273e6() {
  if(level.var_ee8a6b555302846f != level.var_6d38a19a6da9bc01) {
    setsundirection(anglesToForward(level.var_6d38a19a6da9bc01));
    level.var_ee8a6b555302846f = level.var_6d38a19a6da9bc01;
  }
}

function function_1a63eead5c113374() {
  if(level.var_ee8a6b555302846f != level.var_38a05abad5d6656b) {
    setsundirection(anglesToForward(level.var_38a05abad5d6656b));
    level.var_ee8a6b555302846f = level.var_38a05abad5d6656b;
  }
}

function function_7ba7b6df6537fc07() {
  if(starts::is_after_start("stadium_combat_stairs")) {
    function_18f08f56aec273e6();
    return;
  }

  function_1a63eead5c113374();
}

function stairs_sun_switch_thread() {
  level notify("stairs_sun_switch_thread");
  level endon("stairs_sun_switch_thread");
  volume = getEnt("sun_switch_volume", "targetname");

  if(!isDefined(volume)) {
    return;
  }

  while(true) {
    if(level.player istouching(volume)) {
      function_18f08f56aec273e6();
      return;
    }

    wait 1;
  }
}

function function_9c946a04ddaf2d6c(var_bf385726b0a8eea3) {
  if(!isDefined(var_bf385726b0a8eea3) || var_bf385726b0a8eea3.size <= 0) {
    return;
  }

  foreach(light in var_bf385726b0a8eea3) {
    light setlightcolor((1, 1, 1));
    light setlightintensity(3);
    light.og_intensity = light getlightintensity();
    light setlightintensity(0);
    light thread fb_alarm_light_strobe(0.05, 0.05, 0.05, 0.05, 2, 1);
  }
}

function fb_alarm_light_strobe(ontime, offtime, var_49f028f834d4e71b, var_e76de926e3aee959, count, var_4e7f85c4bd662075) {
  self notify("fb_alarm_light_strobe");
  self endon("fb_alarm_light_strobe");
  self endon("death");
  randomstartdelay = randomfloatrange(0.05, 0.35);
  wait randomstartdelay;

  while(true) {
    for(i = 0; i < count; i++) {
      wait offtime;

      if(var_49f028f834d4e71b <= 0) {
        self setlightintensity(self.og_intensity);
      } else {
        scripts\common\lighting::function_70a9f70afd49dead(var_49f028f834d4e71b, self.og_intensity);
      }

      wait ontime;

      if(var_e76de926e3aee959 <= 0) {
        self setlightintensity(0);
        continue;
      }

      scripts\common\lighting::function_70a9f70afd49dead(var_e76de926e3aee959, 0);
    }

    wait var_4e7f85c4bd662075;
  }
}

function function_1d630e974680d15e() {
  var_747e06c0b98abc58 = getEntArray("cinematic_light", "targetname");
  level.unique_lights = [];
  level.var_e841a10ca12d3ced = [];

  foreach(light in var_747e06c0b98abc58) {
    light.og_intensity = light getlightintensity();
    light setlightintensity(0);

    if(isDefined(light.script_parameters) && light.script_parameters != "") {
      level.unique_lights[light.script_parameters] = light;
    }

    light.scene_shots = light function_2db8baa8be717dce();
    level.var_e841a10ca12d3ced[level.var_e841a10ca12d3ced.size] = light;
  }

  if(getdvarint(@ "hash_e6afce2cf5cf7515") == 1) {
    function_318f3b408eb88511(level.var_e841a10ca12d3ced, "sh000");
    function_862591b7b92c10c7();
    return;
  }

  function_97479c7df424d62a();
}

function function_862591b7b92c10c7() {
  models = getEntArray("capture_only", "targetname");

  foreach(m in models) {
    m show();
  }
}

function function_97479c7df424d62a() {
  models = getEntArray("capture_only", "targetname");

  foreach(m in models) {
    m hide();
  }
}

function function_2db8baa8be717dce() {
  if(!isDefined(self.script_noteworthy)) {
    return [];
  }

  return strtok(self.script_noteworthy, " ");
}

function function_318f3b408eb88511(light_list, scene_shot) {
  foreach(light in light_list) {
    if(array_contains(light.scene_shots, scene_shot)) {
      if(abs(light getlightintensity() - light.og_intensity) > 1e-05) {
        light setlightintensity(light.og_intensity);
      }
    }
  }
}

function function_4f68acac1881a018(light_list, scene_shot) {
  ret_list = [];

  foreach(light in light_list) {
    if(array_contains(light.scene_shots, scene_shot)) {
      ret_list[ret_list.size] = light;
    }
  }

  return ret_list;
}

function function_d2f026db9170974b(light_list, scene_shot) {
  foreach(light in light_list) {
    if(array_contains(light.scene_shots, scene_shot)) {
      if(abs(light getlightintensity()) > 1e-05) {
        light setlightintensity(0);
      }
    }
  }
}

function function_f5600319797ffa1e(intensity) {
  if(isDefined(self)) {
    self setlightintensity(intensity);
  }
}

function function_70a9f70afd49dead(from, to, time) {
  if(!isDefined(self)) {
    return;
  }

  steps = int(time * 20);
  curr = from;
  inc = (to - curr) / steps;

  for(i = 0; i < steps; i++) {
    self setlightintensity(curr + i * inc);
    wait 0.05;
  }

  self setlightintensity(to);
}

function function_250adab5270ce6c8(anime) {
  hasxcam = 0;
  var_c29be8a72c384d19 = 0;

  if(isDefined(level.scr_xcam) && isDefined(level.scr_xcam[anime])) {
    hasxcam = 1;
  }

  if(isDefined(level.scr_anim) && isDefined(level.scr_anim["player_rig"]) && isDefined(level.scr_anim["player_rig"][anime])) {
    var_c29be8a72c384d19 = 1;
  }

  if(hasxcam) {
    return getxcamlength(level.scr_xcam[anime]);
  } else if(var_c29be8a72c384d19) {
    return getanimlength(level.scr_anim["player_rig"][anime]);
  }

  return 0;
}

function function_5304c669ebdedf09() {
  var_973bdf858940ca5 = function_90e107731c52501b("infil_veh");

  if(!isDefined(var_973bdf858940ca5)) {
    return;
  }

  var_3b1a5914c5ccb346 = function_90e107731c52501b("exfil_heli");

  if(!isDefined(var_3b1a5914c5ccb346)) {
    return;
  }

  level.var_15793ff8dfdb8f8b = [];
  level.var_15793ff8dfdb8f8b["infil_veh"] = var_973bdf858940ca5;
  level.var_15793ff8dfdb8f8b["exfil_heli"] = var_3b1a5914c5ccb346;
}

function function_90e107731c52501b(animname) {
  var_18d9e97e9af188d6 = animname + "_light_origin";
  var_78e7c15b32cbe1e8 = getEnt(var_18d9e97e9af188d6, "targetname");

  if(!isDefined(var_78e7c15b32cbe1e8)) {
    return undefined;
  }

  lights = var_78e7c15b32cbe1e8 get_linked_ents();

  foreach(light in lights) {
    light linkTo(var_78e7c15b32cbe1e8);

    if(light.classname == "reflection_probe") {
      var_78e7c15b32cbe1e8.probe = light;
    }
  }

  return var_78e7c15b32cbe1e8;
}

function function_9985ab0a5b897efb(ent, var_fa890e641f17ea50) {
  if(!isDefined(level.var_15793ff8dfdb8f8b)) {
    return;
  }

  level.var_15793ff8dfdb8f8b[var_fa890e641f17ea50].origin = ent.origin;
  level.var_15793ff8dfdb8f8b[var_fa890e641f17ea50].angles = ent.angles;
  level.var_15793ff8dfdb8f8b[var_fa890e641f17ea50] linkTo(ent);
}

function function_67d35fd53f94e241(var_fa890e641f17ea50) {
  if(!isDefined(level.var_15793ff8dfdb8f8b)) {
    return;
  }

  if(isDefined(level.var_15793ff8dfdb8f8b[var_fa890e641f17ea50]) && isDefined(level.var_15793ff8dfdb8f8b[var_fa890e641f17ea50].probe)) {
    level.var_15793ff8dfdb8f8b[var_fa890e641f17ea50].probe hide();
  }
}

function function_b0a2ca3b6db38274(anime) {
  anim_length = function_250adab5270ce6c8(anime) + function_e18b3e7308279868(anime);

  switch (anime) {
    case #"hash_6f7c9dfd5086c4bf":
      function_c6f71099276d841c();
      wait anim_length;
      function_c24d6f32279228e5();
      break;
    case #"hash_6f7c98fd5086bce0":
      function_f8b1c9cad0773e57();
      wait anim_length;
      function_13053854dac1bd52();
      break;
    case #"hash_6f732bfd507f5584":
      function_b456cf8d3d4c8173();
      wait anim_length;
      function_972ed233b777a446();
      break;
    case #"hash_6f7328fd507f50cb":
      function_5c75c82922d8930();
      wait anim_length;
      function_dcd6515083cb8e91();
      break;
    case #"hash_6f7631fd50819d8d":
      function_681617dea0879536();
      wait anim_length;
      function_14290a4a4e047333();
      break;
    case #"hash_6f762cfd508195ae":
      function_b7c163f598700371();
      wait anim_length;
      function_759131da5b821990();
      break;
    case #"hash_6f6c9ffd5079fbf2":
      function_d511d9259ed3bbdd();
      wait anim_length;
      function_7a71bbf415db2a24();
      break;
    case #"hash_6f6c9cfd5079f739":
      function_c52d1240529591ea();
      wait anim_length;
      function_8cd15f52085ae59f();
      break;
    case #"hash_6f7025fd507d0d7b":
      function_c874455412898a20();
      wait anim_length;
      function_493923fdb6acbac1();
      break;
    case #"hash_6f7028fd507d1234":
      function_cd2a2a37a828de63();
      wait anim_length;
      function_29f7e4ee39b4a4f6();
      break;
    case #"hash_6f6693fd50756be0":
      function_df29a84633d973b7();
      wait anim_length;
      function_60e4c8c57a9a99b2();
      break;
    case #"hash_6f6698fd507573bf":
      function_e90eaad1f7fb4bfc();
      wait anim_length;
      function_cea0b55048ca9c5();
      break;
    case #"hash_6f6999fd5077b3e9":
      function_f1b070ff3fa8e81a();
      wait anim_length;
      function_29ce70da176f630f();
      break;
    case #"hash_6f699cfd5077b8a2":
      function_fca5f2df20a8018d();
      wait anim_length;
      function_9c9dc1bf49aa3414();
      break;
    default:
      break;
  }
}

function function_e18b3e7308279868(anime) {
  switch (anime) {
    case #"hash_6f7c9dfd5086c4bf":
      return -0.05;
    case #"hash_6f7c98fd5086bce0":
      return -0.05;
    case #"hash_6f732bfd507f5584":
      return -0.05;
    case #"hash_6f7328fd507f50cb":
      return -0.05;
    case #"hash_6f7631fd50819d8d":
      return -0.05;
    case #"hash_6f762cfd508195ae":
      return -0.05;
    case #"hash_6f6c9ffd5079fbf2":
      return -0.05;
    case #"hash_6f6c9cfd5079f739":
      return -0.05;
    case #"hash_6f7025fd507d0d7b":
      return -0.05;
    case #"hash_6f7028fd507d1234":
      return -0.05;
    case #"hash_6f6693fd50756be0":
      return -0.05;
    case #"hash_6f6698fd507573bf":
      return -0.05;
    case #"hash_6f6999fd5077b3e9":
      return -0.05;
    case #"hash_6f699cfd5077b8a2":
      return -0.05;
    default:
      return -0.05;
  }
}

function function_ee3c8174ce5e31ca() {
  if(isplatformxb3() || isplatformps4()) {
    setsaveddvar(@ "hash_6e3f8cef6be16b33", 1);
    setsaveddvar(@ "hash_b8c4ce378e61b803", 2);
  }
}

function function_99823bb15eb428fd() {
  if(isplatformxb3() || isplatformps4()) {
    setsaveddvar(@ "hash_6e3f8cef6be16b33", 0);
    setsaveddvar(@ "hash_b8c4ce378e61b803", 1);
  }
}

function function_c6f71099276d841c() {
  function_318f3b408eb88511(level.var_e841a10ca12d3ced, "midtro10");
  function_ee3c8174ce5e31ca();
  setsaveddvar(@ "hash_8667c0bb90c5bfc3", "350");
  setsaveddvar(@ "hash_63eb1893f96ac98d", "8");
  setsaveddvar(@ "hash_5d66c2ef5a9612e0", 0);
  setsaveddvar(@ "hash_eca4b727b01fd254", 0.57);
  setsaveddvar(@ "hash_f9190cd77b0b2463", 2.5);
}

function function_c24d6f32279228e5() {
  function_d2f026db9170974b(level.var_e841a10ca12d3ced, "midtro10");
  function_318f3b408eb88511(level.var_e841a10ca12d3ced, "midtro15");
}

function function_f8b1c9cad0773e57() {
  setsaveddvar(@ "hash_eca4b727b01fd254", 4.783);
  setsaveddvar(@ "hash_f9190cd77b0b2463", 4.1);
}

function function_13053854dac1bd52() {
  function_d2f026db9170974b(level.var_e841a10ca12d3ced, "midtro15");
  function_318f3b408eb88511(level.var_e841a10ca12d3ced, "midtro20");
}

function function_b456cf8d3d4c8173() {
  setsaveddvar(@ "hash_eca4b727b01fd254", 2.164);
  setsaveddvar(@ "hash_f9190cd77b0b2463", 3.758);
}

function function_972ed233b777a446() {
  function_d2f026db9170974b(level.var_e841a10ca12d3ced, "midtro20");
  function_318f3b408eb88511(level.var_e841a10ca12d3ced, "midtro25");
}

function function_5c75c82922d8930() {
  setsaveddvar(@ "hash_eca4b727b01fd254", 1.936);
  setsaveddvar(@ "hash_f9190cd77b0b2463", 2.391);
}

function function_dcd6515083cb8e91() {
  function_d2f026db9170974b(level.var_e841a10ca12d3ced, "midtro25");
  function_318f3b408eb88511(level.var_e841a10ca12d3ced, "midtro30");
}

function function_681617dea0879536() {
  setsaveddvar(@ "hash_eca4b727b01fd254", 5.466);
  setsaveddvar(@ "hash_f9190cd77b0b2463", 11.046);
}

function function_14290a4a4e047333() {
  function_d2f026db9170974b(level.var_e841a10ca12d3ced, "midtro30");
  function_318f3b408eb88511(level.var_e841a10ca12d3ced, "midtro35");
}

function function_b7c163f598700371() {
  setsaveddvar(@ "hash_eca4b727b01fd254", 2.505);
  setsaveddvar(@ "hash_f9190cd77b0b2463", 6.377);
}

function function_759131da5b821990() {
  function_d2f026db9170974b(level.var_e841a10ca12d3ced, "midtro35");
  function_318f3b408eb88511(level.var_e841a10ca12d3ced, "midtro40");
}

function function_d511d9259ed3bbdd() {
  setsaveddvar(@ "hash_eca4b727b01fd254", 3.986);
  setsaveddvar(@ "hash_f9190cd77b0b2463", 2.733);
}

function function_7a71bbf415db2a24() {
  function_d2f026db9170974b(level.var_e841a10ca12d3ced, "midtro40");
  function_318f3b408eb88511(level.var_e841a10ca12d3ced, "midtro45");
}

function function_c52d1240529591ea() {
  setsaveddvar(@ "hash_eca4b727b01fd254", 1.139);
  setsaveddvar(@ "hash_f9190cd77b0b2463", 3.075);
}

function function_8cd15f52085ae59f() {
  function_d2f026db9170974b(level.var_e841a10ca12d3ced, "midtro45");
  function_318f3b408eb88511(level.var_e841a10ca12d3ced, "midtro50");
}

function function_c874455412898a20() {
  setsaveddvar(@ "hash_eca4b727b01fd254", 1.367);
  setsaveddvar(@ "hash_f9190cd77b0b2463", 4.214);
}

function function_493923fdb6acbac1() {
  function_d2f026db9170974b(level.var_e841a10ca12d3ced, "midtro50");
  function_318f3b408eb88511(level.var_e841a10ca12d3ced, "midtro55");
}

function function_cd2a2a37a828de63() {
  setsaveddvar(@ "hash_eca4b727b01fd254", 1.253);
  setsaveddvar(@ "hash_f9190cd77b0b2463", 7.63);
}

function function_29f7e4ee39b4a4f6() {
  function_d2f026db9170974b(level.var_e841a10ca12d3ced, "midtro55");
  function_318f3b408eb88511(level.var_e841a10ca12d3ced, "midtro60");
}

function function_df29a84633d973b7() {
  setsaveddvar(@ "hash_eca4b727b01fd254", 0.683);
  setsaveddvar(@ "hash_f9190cd77b0b2463", 3.416);
}

function function_60e4c8c57a9a99b2() {
  function_d2f026db9170974b(level.var_e841a10ca12d3ced, "midtro60");
  function_318f3b408eb88511(level.var_e841a10ca12d3ced, "midtro65");
}

function function_e90eaad1f7fb4bfc() {
  setsaveddvar(@ "hash_eca4b727b01fd254", 1.367);
  setsaveddvar(@ "hash_f9190cd77b0b2463", 6.833);
}

function function_cea0b55048ca9c5() {
  function_d2f026db9170974b(level.var_e841a10ca12d3ced, "midtro65");
  function_318f3b408eb88511(level.var_e841a10ca12d3ced, "midtro70");
}

function function_f1b070ff3fa8e81a() {
  setsaveddvar(@ "hash_eca4b727b01fd254", 2.961);
  setsaveddvar(@ "hash_f9190cd77b0b2463", 6.377);
}

function function_29ce70da176f630f() {
  function_d2f026db9170974b(level.var_e841a10ca12d3ced, "midtro70");
  function_318f3b408eb88511(level.var_e841a10ca12d3ced, "midtro75");
}

function function_fca5f2df20a8018d() {
  setsaveddvar(@ "hash_eca4b727b01fd254", 2.505);
  setsaveddvar(@ "hash_f9190cd77b0b2463", 14.577);
}

function function_9c9dc1bf49aa3414() {
  function_d2f026db9170974b(level.var_e841a10ca12d3ced, "midtro75");
  setsaveddvar(@ "hash_8667c0bb90c5bfc3", "1200");
  setsaveddvar(@ "hash_63eb1893f96ac98d", "6");
  function_99823bb15eb428fd();
  setsaveddvar(@ "hash_5d66c2ef5a9612e0", 1);
}

function function_e672a8b815c0a7f0() {
  setsaveddvar(@ "hash_dc2a068a92678456", 0);
}