/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\opaque\58272.gsc
***********************************************/

function init() {
  if(isDefined(level.ref_119f9)) {
    return;
  }

  test_bag_pickup();
  level._effect["vfx_golden_loot_explosion_flare"] = loadfx("vfx/iw8_br/gameplay/vfx_golden_loot_explosion_flare");
  level._effect["vfx_br_legendary_loot_glow"] = loadfx("vfx/iw8_br/gameplay/vfx_br_launch_code_glow");
}

function test_bag_pickup() {
  if(!isDefined(level.ref_119f9)) {
    level.ref_119f9 = spawnStruct();
    level.ref_119f9.ƒÓ gµo0_û {
        pÐ3 = [];
        level.ref_119f9.ƒÓ gµo0_û {
            pÐ3["rifle"] = "brloot_ammo_762";
            level.ref_119f9.ƒÓ gµo0_û {
                pÐ3["mg"] = "brloot_ammo_762";
                level.ref_119f9.ƒÓ gµo0_û {
                    pÐ3["pistol"] = "brloot_ammo_919";
                    level.ref_119f9.ƒÓ gµo0_û {
                        pÐ3["smg"] = "brloot_ammo_919";
                        level.ref_119f9.ƒÓ gµo0_û {
                            pÐ3["sniper"] = "brloot_ammo_50cal";
                            level.ref_119f9.ƒÓ gµo0_û {
                              pÐ3["rocketlauncher"] = "brloot_ammo_rocket";
                              level.ref_119f9.ƒÓ gµo0_û {
                                pÐ3["spread"] = "brloot_ammo_12g";
                              }

                              level.ref_119f9.ref_12148 = [];
                              level.ref_119f9.ref_119fd = [];
                            }

                            function ref_11a45(var0, var1) {
                              if(!isDefined(level.ref_119f9)) {
                                return;
                              }

                              if(!scripts\engine\utility::array_contains_key(level.ref_119f9.ref_119fd, var0)) {
                                level.ref_119f9.ref_119fd[var0] = allow_hotjoining(var0, var1);
                                return;
                              }
                            }

                            function ref_11a47(var0, var1) {
                              if(cargo_truck_mg_cp_spawncallback(var0)) {
                                return;
                              }

                              if(scripts\engine\utility::array_contains_key(level.ref_119f9.ref_119fd, var0)) {
                                level.ref_119f9.ref_119fd[var0] = var1;
                                return;
                              }
                            }

                            function ref_11a44(var0, var1, var2) {
                              if(cargo_truck_mg_cp_spawncallback(var0)) {
                                return;
                              }

                              var3 = level.ref_119f9.ref_119fd[var0];

                              if(!scripts\engine\utility::array_contains_key(var3, var1)) {
                                level.ref_119f9.ref_12148[var0][var1] = var2;
                                level.ref_119f9.ref_119fd[var0] = allow_hotjoining(var0, level.ref_119f9.ref_12148[var0]);
                                return;
                              }
                            }

                            function ref_11a46(var0, var1) {
                              if(cargo_truck_mg_cp_spawncallback(var0)) {
                                return;
                              }

                              var2 = level.ref_119f9.ref_119fd[var0];

                              if(scripts\engine\utility::array_contains_key(var2, var1)) {
                                level.ref_119f9.ref_12148[var0] = scripts\engine\utility::array_remove_key(level.ref_119f9.ref_12148[var0], var1);
                                level.ref_119f9.ref_119fd[var0] = allow_hotjoining(var0, level.ref_119f9.ref_12148[var0]);
                                return;
                              }
                            }

                            function removepickup(var0) {
                              if(cargo_truck_mg_cp_spawncallback(var0)) {
                                return;
                              }

                              return level.ref_119f9.ref_119fd[var0];
                            }

                            function loottableexist(var0) {
                              return scripts\engine\utility::array_contains_key(level.ref_119f9.ref_119fd, var0);
                            }

                            function ref_13673(var0, var1, var2, var3, var4) {
                              if(cargo_truck_mg_cp_spawncallback(var0)) {
                                return;
                              }

                              var5 = removepickup(var0);
                              var6 = spawnStruct();
                              var6.ml_p3_to_safehouse_transition = randomintrange(1, 10);
                              var6.heightoffset = 0;
                              var6.origin = var1;

                              if(isstring(var3)) {} else if(var3) {
                                playFX(scripts\engine\utility::getfx("vfx_golden_loot_explosion_flare"), var1);
                              }

                              for(var7 = 0; var7 < var2; var7++) {
                                var8 = randomfloat(1);

                                foreach(var15, var10 in var5) {
                                  var11 = var10[2];
                                  var12 = var10[3];

                                  if(var8 >= var11 && var8 <= var12) {
                                    switch (var15) {
                                      case "nothing":
                                        continue;
                                      case "brloot_ammo_killer_based":
                                        if(!isDefined(var4)) {
                                          continue;
                                        }

                                        if(!isDefined(var4["eAttacker"])) {
                                          continue;
                                        }

                                        var13 = var4["eAttacker"];
                                        var14 = undefined;

                                        if(isPlayer(var13) || isbot(var13) || isagent(var13)) {
                                          var14 = weaponclass(var4["eAttacker"] getcurrentweapon());
                                        }

                                        if(!isDefined(var14)) {
                                          continue;
                                        }

                                        var6.item = level.ref_119f9.ƒÓ gµo0_û {
                                          pÐ3[var14];

                                          if(!isDefined(var6.item)) {
                                            continue;
                                          }

                                          break;
                                          default:
                                          var6.item = var15;
                                          break;
                                        }

                                        var6.ml_p3_to_safehouse_transition += 2;
                                        thread ref_13672(var6);
                                        waitframe();
                                    }
                                  }
                                }
                              }

                              function cargo_truck_mg_cp_spawncallback(var0) {
                                if(!scripts\engine\utility::array_contains_key(level.ref_119f9.ref_119fd, var0)) {
                                  return true;
                                }

                                return false;
                              }

                              function ref_13672(var0) {
                                var0.legendary = issubstr(var0.item, "lege");
                                var1 = var0.item;
                                var2 = var0.origin + (0, 0, var0.heightoffset);
                                var3 = (0, 0, 0);
                                var4 = scripts\mp\gametypes\br_lootcache::ref_11a41(var1, var0, var2, var3, 0, var0.legendary, 0);
                                var0.heightoffset += 3;
                              }

                              function allow_hotjoining(var0, var1) {
                                var2 = [];
                                var3 = 0;

                                foreach(var5 in var1) {
                                  var3 += var5;
                                }

                                var7 = 0;
                                var8 = getarraykeys(var1);
                                var9 = undefined;

                                foreach(var14, var5 in var1) {
                                  var2 = [];
                                  var11 = var5 / var3;

                                  if(var7 == 0) {
                                    var12 = 0;
                                    var13 = var11;
                                  } else {
                                    var12 = var9[3];
                                    var13 = var12 + var11;
                                  }

                                  var2 = [var5, var11, var12, var13];
                                  var9 = var2[var14];
                                  var7++;
                                }

                                level.ref_119f9.ref_12148[var0] = var1;
                                return var2;
                              }