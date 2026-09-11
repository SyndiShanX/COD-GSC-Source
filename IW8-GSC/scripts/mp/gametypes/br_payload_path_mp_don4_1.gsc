/**************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\br_payload_path_mp_don4_1.gsc
**************************************************************/

function toggle_farah_lights(var0, var1, var2) {
  if(level.mapname != "mp_don4") {
    return;
  }

  if(level.disable_super_in_turret.ref_1226a != var1 && !isDefined(level.disable_super_in_turret.ref_121fd)) {
    return;
  }

  if(!isDefined(level.disable_super_in_turret.paths)) {
    level.disable_super_in_turret.paths = [];
  }

  var3 = spawnStruct();
  var3.nodes = [];
  var3.origin = (14652.9, -29003.6, -331.232);
  var3.script_index = var0;
  var3.initchallengeandeventglobals = var2;
  var3.nodes[0] = var3;
  var4 = var3.nodes.size;
  var3.nodes[var4] = spawnStruct();
  var3.nodes[var4].origin = (14826.6, -28480.2, -335.037);
  var4 = var3.nodes.size;
  var3.nodes[var4] = spawnStruct();
  var3.nodes[var4].origin = (14942.3, -27993.6, -334.783);
  var4 = var3.nodes.size;
  var3.nodes[var4] = spawnStruct();
  var3.nodes[var4].origin = (15060.6, -27507.1, -326.228);
  var4 = var3.nodes.size;
  var3.nodes[var4] = spawnStruct();
  var3.nodes[var4].origin = (15207.3, -27029.5, -296.804);
  var4 = var3.nodes.size;
  var3.nodes[var4] = spawnStruct();
  var3.nodes[var4].origin = (15366.9, -26556, -255.822);
  var4 = var3.nodes.size;
  var3.nodes[var4] = spawnStruct();
  var3.nodes[var4].origin = (15520.9, -26080.1, -220.39);
  var4 = var3.nodes.size;
  var3.nodes[var4] = spawnStruct();
  var3.nodes[var4].origin = (15632.9, -25592.5, -204.751);
  var4 = var3.nodes.size;
  var3.nodes[var4] = spawnStruct();
  var3.nodes[var4].origin = (15708.1, -25097.1, -203.943);
  var4 = var3.nodes.size;
  var3.nodes[var4] = spawnStruct();
  var3.nodes[var4].origin = (15737.3, -24596.5, -204.345);
  var4 = var3.nodes.size;
  var3.nodes[var4] = spawnStruct();
  var3.nodes[var4].origin = (15741, -24096.4, -204.776);
  var3.nodes[var4].obstacle = spawnStruct();
  var3.nodes[var4].obstacle.origin = (15731.5, -23706.5, -202.677);
  var3.nodes[var4].obstacle.angles = (360.039, 91.3972, 0);
  var4 = var3.nodes.size;
  var3.nodes[var4] = spawnStruct();
  var3.nodes[var4].origin = (15728.8, -23596.2, -205.122);
  var4 = var3.nodes.size;
  var3.nodes[var4] = spawnStruct();
  var3.nodes[var4].origin = (15728.5, -23096, -205.463);
  var4 = var3.nodes.size;
  var3.nodes[var4] = spawnStruct();
  var3.nodes[var4].origin = (15747.1, -22373.9, -203.452);
  var4 = var3.nodes.size;
  var3.nodes[var4] = spawnStruct();
  var3.nodes[var4].origin = (15908.7, -21843.1, -209.579);
  var3.nodes[var4].checkpoint = 1;
  var4 = var3.nodes.size;
  var3.nodes[var4] = spawnStruct();
  var3.nodes[var4].origin = (16274.2, -21849.6, -207.875);
  var4 = var3.nodes.size;
  var3.nodes[var4] = spawnStruct();
  var3.nodes[var4].origin = (16732.7, -21848.4, -210.341);
  var4 = var3.nodes.size;
  var3.nodes[var4] = spawnStruct();
  var3.nodes[var4].origin = (17297.5, -21861.9, -210.83);
  var4 = var3.nodes.size;
  var3.nodes[var4] = spawnStruct();
  var3.nodes[var4].origin = (17668.3, -21526, -210.762);
  var4 = var3.nodes.size;
  var3.nodes[var4] = spawnStruct();
  var3.nodes[var4].origin = (18000, -21154.1, -172.563);
  var3.nodes[var4].obstacle = spawnStruct();
  var3.nodes[var4].obstacle.origin = (18292.3, -20895.9, -173.766);
  var3.nodes[var4].obstacle.angles = (360.419, 41.4541, 0);
  var4 = var3.nodes.size;
  var3.nodes[var4] = spawnStruct();
  var3.nodes[var4].origin = (18373.6, -20824.1, -176.053);
  var4 = var3.nodes.size;
  var3.nodes[var4] = spawnStruct();
  var3.nodes[var4].origin = (18692.7, -20439, -172.275);
  var4 = var3.nodes.size;
  var3.nodes[var4] = spawnStruct();
  var3.nodes[var4].origin = (19075.9, -20089, -150.45);
  var4 = var3.nodes.size;
  var3.nodes[var4] = spawnStruct();
  var3.nodes[var4].origin = (19407.2, -19763.4, -130.805);
  var4 = var3.nodes.size;
  var3.nodes[var4] = spawnStruct();
  var3.nodes[var4].origin = (19755.5, -19416.1, -119.963);
  var4 = var3.nodes.size;
  var3.nodes[var4] = spawnStruct();
  var3.nodes[var4].origin = (20116.9, -19039.2, -119.892);
  var3.nodes[var4].obstacle = spawnStruct();
  var3.nodes[var4].obstacle.origin = (20394.3, -18765.2, -128.317);
  var3.nodes[var4].obstacle.angles = (362.841, 44.647, 0);
  var4 = var3.nodes.size;
  var3.nodes[var4] = spawnStruct();
  var3.nodes[var4].origin = (20451.7, -18708.5, -131.472);
  var4 = var3.nodes.size;
  var3.nodes[var4] = spawnStruct();
  var3.nodes[var4].origin = (20819.7, -18315.9, -147.985);
  var3.nodes[var4].checkpoint = 1;
  var4 = var3.nodes.size;
  var3.nodes[var4] = spawnStruct();
  var3.nodes[var4].origin = (21183.1, -17995.3, -165.688);
  var4 = var3.nodes.size;
  var3.nodes[var4] = spawnStruct();
  var3.nodes[var4].origin = (21520.2, -17664.5, -184.033);
  var4 = var3.nodes.size;
  var3.nodes[var4] = spawnStruct();
  var3.nodes[var4].origin = (21837.5, -17305.7, -201.793);
  var4 = var3.nodes.size;
  var3.nodes[var4] = spawnStruct();
  var3.nodes[var4].origin = (22235.7, -16958.8, -214.122);
  var3.nodes[var4].obstacle = spawnStruct();
  var3.nodes[var4].obstacle.origin = (22497.1, -16669.4, -218.769);
  var3.nodes[var4].obstacle.angles = (362.358, 47.9181, 0);
  var4 = var3.nodes.size;
  var3.nodes[var4] = spawnStruct();
  var3.nodes[var4].origin = (22576.4, -16581.5, -220.435);
  var4 = var3.nodes.size;
  var3.nodes[var4] = spawnStruct();
  var3.nodes[var4].origin = (22765.5, -16251.5, -215.88);
  var4 = var3.nodes.size;
  var3.nodes[var4] = spawnStruct();
  var3.nodes[var4].origin = (22757, -15610.5, -218.46);
  var4 = var3.nodes.size;
  var3.nodes[var4] = spawnStruct();
  var3.nodes[var4].origin = (22739.1, -15109.7, -218.582);
  var4 = var3.nodes.size;
  var3.nodes[var4] = spawnStruct();
  var3.nodes[var4].origin = (22715.9, -14609.9, -218.404);
  var4 = var3.nodes.size;
  var3.nodes[var4] = spawnStruct();
  var3.nodes[var4].origin = (22719.9, -14109.5, -218.337);
  var3.nodes[var4].obstacle = spawnStruct();
  var3.nodes[var4].obstacle.origin = (22730.2, -13719.6, -216);
  var3.nodes[var4].obstacle.angles = (360, 88.4872, 0);
  var4 = var3.nodes.size;
  var3.nodes[var4] = spawnStruct();
  var3.nodes[var4].origin = (22733.1, -13609.7, -218.212);
  var4 = var3.nodes.size;
  var3.nodes[var4] = spawnStruct();
  var3.nodes[var4].origin = (22738.3, -13057.3, -218.348);
  scripts\mp\gametypes\br_gametype_payload::ref_1318d(var0, var2);
  level.disable_super_in_turret.paths[level.disable_super_in_turret.paths.size] = var3;
}