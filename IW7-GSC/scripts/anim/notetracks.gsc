/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: scripts\anim\notetracks.gsc
*********************************************/

registernotetracks_init() {
  if(isDefined(level.notetracks)) {
    return;
  }

  anim.notetracks = [];
  registernotetracks();
}

registernotetracks() {
    level.notetracks["anim_pose = \"stand\"] = ::notetrackposestand;
        level.notetracks["anim_pose = \"crouch\"] = ::notetrackposecrouch;
          level.notetracks["anim_pose = \"prone\"] = ::notetrackposeprone;
            level.notetracks["anim_pose = \"crawl\"] = ::notetrackposecrawl;
              level.notetracks["anim_pose = \"back\"] = ::notetrackposeback;
                level.notetracks["anim_movement = \"stop\"] = ::notetrackmovementstop;
                  level.notetracks["anim_movement = \"walk\"] = ::notetrackmovementwalk;
                    level.notetracks["anim_movement = \"run\"] = ::notetrackmovementrun;
                      level.notetracks["anim_gunhand = \"left\"] = ::notetrackgunhand;
                        level.notetracks["anim_gunhand = \"right\"] = ::notetrackgunhand;
                          level.notetracks["anim_gunhand = \"none\"] = ::notetrackgunhand;
                            level.notetracks["anim_pose = stand"] = ::notetrackposestand; level.notetracks["anim_pose = crouch"] = ::notetrackposecrouch; level.notetracks["anim_pose = prone"] = ::notetrackposeprone; level.notetracks["anim_pose = crawl"] = ::notetrackposecrawl; level.notetracks["anim_pose = back"] = ::notetrackposeback; level.notetracks["anim_movement = stop"] = ::notetrackmovementstop; level.notetracks["anim_movement = walk"] = ::notetrackmovementwalk; level.notetracks["anim_movement = run"] = ::notetrackmovementrun; level.notetracks["anim_movement_gun_pose_override = run_gun_down"] = ::notetrackmovementgunposeoverride; level.notetracks["anim_aiming = 1"] = ::notetrackalertnessaiming; level.notetracks["anim_aiming = 0"] = ::notetrackalertnessalert; level.notetracks["anim_alertness = causal"] = ::notetrackalertnesscasual; level.notetracks["anim_alertness = alert"] = ::notetrackalertnessalert; level.notetracks["anim_alertness = aiming"] = ::notetrackalertnessaiming; level.notetracks["gunhand = (gunhand)_left"] = ::notetrackgunhand; level.notetracks["anim_gunhand = left"] = ::notetrackgunhand; level.notetracks["gunhand = (gunhand)_right"] = ::notetrackgunhand; level.notetracks["anim_gunhand = right"] = ::notetrackgunhand; level.notetracks["anim_gunhand = none"] = ::notetrackgunhand; level.notetracks["gun drop"] = ::notetrackgundrop; level.notetracks["dropgun"] = ::notetrackgundrop; level.notetracks["gun_2_chest"] = ::notetrackguntochest; level.notetracks["gun_2_back"] = ::notetrackguntoback; level.notetracks["pistol_pickup"] = ::notetrackpistolpickup; level.notetracks["pistol_putaway"] = ::notetrackpistolputaway; level.notetracks["drop clip"] = ::notetrackdropclip; level.notetracks["refill clip"] = ::notetrackrefillclip; level.notetracks["reload done"] = ::notetrackrefillclip; level.notetracks["load_shell"] = ::notetrackloadshell; level.notetracks["pistol_rechamber"] = ::notetrackpistolrechamber; level.notetracks["gravity on"] = ::notetrackgravity; level.notetracks["gravity off"] = ::notetrackgravity; level.notetracks["footstep_right_large"] = ::notetrackfootstep; level.notetracks["footstep_right_small"] = ::notetrackfootstep; level.notetracks["footstep_left_large"] = ::notetrackfootstep; level.notetracks["footstep_left_small"] = ::notetrackfootstep; level.notetracks["handstep_left"] = ::notetrackhandstep; level.notetracks["handstep_right"] = ::notetrackhandstep; level.notetracks["footscrape"] = ::notetrackfootscrape; level.notetracks["land"] = ::notetrackland; level.notetracks["bodyfall large"] = ::notetrackbodyfall; level.notetracks["bodyfall small"] = ::notetrackbodyfall; level.notetracks["code_move"] = ::notetrackcodemove; level.notetracks["face_enemy"] = ::notetrackfaceenemy; level.notetracks["laser_on"] = ::notetracklaser; level.notetracks["laser_off"] = ::notetracklaser; level.notetracks["start_ragdoll"] = ::notetrackstartragdoll; level.notetracks["ragdollblendinit"] = ::notetrackragdollblendinit; level.notetracks["ragdollblendstart"] = ::notetrackragdollblendstart; level.notetracks["ragdollblendend"] = ::notetrackragdollblendend; level.notetracks["ragdollblendrootanim"] = ::notetrackragdollblendrootanim; level.notetracks["ragdollblendrootragdoll"] = ::notetrackragdollblendrootragdoll; level.notetracks["fire"] = ::notetrackfire; level.notetracks["fire_spray"] = ::notetrackfirespray; level.notetracks["bloodpool"] = scripts\anim\death::play_blood_pool; level.notetracks["space_jet_top"] = ::notetrackspacejet; level.notetracks["space_jet_top_1"] = ::notetrackspacejet; level.notetracks["space_jet_top_2"] = ::notetrackspacejet; level.notetracks["space_jet_bottom"] = ::notetrackspacejet; level.notetracks["space_jet_bottom_1"] = ::notetrackspacejet; level.notetracks["space_jet_bottom_2"] = ::notetrackspacejet; level.notetracks["space_jet_left"] = ::notetrackspacejet; level.notetracks["space_jet_left_1"] = ::notetrackspacejet; level.notetracks["space_jet_left_2"] = ::notetrackspacejet; level.notetracks["space_jet_right"] = ::notetrackspacejet; level.notetracks["space_jet_right_1"] = ::notetrackspacejet; level.notetracks["space_jet_right_2"] = ::notetrackspacejet; level.notetracks["space_jet_front"] = ::notetrackspacejet; level.notetracks["space_jet_front_1"] = ::notetrackspacejet; level.notetracks["space_jet_front_2"] = ::notetrackspacejet; level.notetracks["space_jet_back"] = ::notetrackspacejet; level.notetracks["space_jet_back_1"] = ::notetrackspacejet; level.notetracks["space_jet_back_2"] = ::notetrackspacejet; level.notetracks["space_jet_back_3"] = ::notetrackspacejet; level.notetracks["space_jet_back_4"] = ::notetrackspacejet; level.notetracks["space_jet_random"] = ::notetrackspacejet; level.notetracks["fingers_out_start_left_hand"] = ::notetrackfingerposeoffleft; level.notetracks["fingers_out_start_right_hand"] = ::notetrackfingerposeoffright; level.notetracks["fingers_in_start_left_hand"] = ::notetrackfingerposeonleft; level.notetracks["fingers_in_start_right_hand"] = ::notetrackfingerposeonright; level.notetracks["anim_facial = idle"] = ::notetrackfacialidle; level.notetracks["anim_facial = run"] = ::notetrackfacialrun; level.notetracks["anim_facial = pain"] = ::notetrackfacialpain; level.notetracks["anim_facial = death"] = ::notetrackfacialdeath; level.notetracks["anim_facial = talk"] = ::notetrackfacialtalk; level.notetracks["anim_facial = cheer"] = ::notetrackfacialcheer; level.notetracks["anim_facial = happy"] = ::notetrackfacialhappy; level.notetracks["anim_facial = angry"] = ::notetrackfacialangry; level.notetracks["anim_facial = scared"] = ::notetrackfacialscared; level.notetracks["visor_raise"] = ::notetrackvisorraise; level.notetracks["visor_lower"] = ::notetrackvisorlower; level.notetracks["c12_death_dying"] = ::func_3538; level.notetracks["c12_death_bodyfall"] = ::func_3537;
                            if(isDefined(level._notetrackfx)) {
                              var_0 = getarraykeys(level._notetrackfx);
                              foreach(var_2 in var_0) {
                                level.notetracks[var_2] = ::customnotetrackfx;
                              }
                            }
                          }

                          func_3538(var_0, var_1) {
                            if(soundexists("generic_death_c12")) {
                              self playSound("generic_death_c12");
                            }
                          }

                          func_3537(var_0, var_1) {
                            if(soundexists("c12_death_generic_bf")) {
                              self playSound("c12_death_generic_bf");
                            }
                          }

                          notetrackfire(var_0, var_1) {
                            if(isDefined(level.fire_notetrack_functions[self.script])) {
                              thread[[level.fire_notetrack_functions[self.script]]]();
                              return;
                            }

                            thread shootnotetrack();
                          }

                          shootnotetrack() {
                            waittillframeend;
                            if(isDefined(self) && gettime() > self.a.var_A9ED) {
                              if(isDefined(self.asm.shootparams)) {
                                var_0 = self.asm.shootparams.var_FF0B == 1;
                              } else {
                                var_0 = 1;
                              }

                              scripts\anim\utility_common::shootenemywrapper(var_0);
                              scripts\anim\combat_utility::decrementbulletsinclip();
                              if(weaponclass(self.var_394) == "rocketlauncher") {
                                self.a.rockets--;
                              }
                            }
                          }

                          notetracklaser(var_0, var_1) {
                            if(issubstr(var_0, "on")) {
                              self.a.laseron = 1;
                            } else {
                              self.a.laseron = 0;
                            }

                            scripts\anim\shared::updatelaserstatus();
                          }

                          notetrackstopanim(var_0, var_1) {}

                          unlinknextframe() {
                            wait(0.1);
                            if(isDefined(self)) {
                              self unlink();
                            }
                          }

                          notetrackstartragdoll(var_0, var_1) {
                            if(isDefined(self.noragdoll)) {
                              return;
                            }

                            if(isDefined(self.ragdolltime)) {
                              return;
                            }

                            if(!isDefined(self.dont_unlink_ragdoll)) {
                              thread unlinknextframe();
                            }

                            if(isDefined(self._blackboard)) {
                              if(isDefined(self._blackboard.var_26C6) && self._blackboard.var_26C6 == 1) {
                                scripts\anim\shared::func_5D19();
                                self.lastweapon = self.var_394;
                              }
                            }

                            if(isDefined(self.var_71C8)) {
                              self[[self.var_71C8]]();
                            }

                            if(isDefined(self)) {
                              self giverankxp();
                            }
                          }

                          notetrackragdollblendinit(var_0, var_1) {
                            if(isDefined(self.noragdoll)) {
                              return;
                            }

                            if(isDefined(self.ragdolltime)) {
                              return;
                            }

                            if(!isDefined(self.dont_unlink_ragdoll)) {
                              thread unlinknextframe();
                            }

                            if(isDefined(self._blackboard)) {
                              if(isDefined(self._blackboard.var_26C6) && self._blackboard.var_26C6 == 1) {
                                scripts\anim\shared::func_5D19();
                                self.lastweapon = self.var_394;
                              }
                            }

                            if(isDefined(self.var_71C8)) {
                              self[[self.var_71C8]]();
                            }

                            self _meth_8576();
                          }

                          notetrackragdollblendstart(var_0, var_1) {}

                          notetrackragdollblendend(var_0, var_1) {}

                          notetrackragdollblendrootanim(var_0, var_1) {}

                          notetrackragdollblendrootragdoll(var_0, var_1) {}

                          notetrackmovementstop(var_0, var_1) {
                            self.a.movement = "stop";
                          }

                          notetrackmovementwalk(var_0, var_1) {
                            self.a.movement = "walk";
                          }

                          notetrackmovementrun(var_0, var_1) {
                            self.a.movement = "run";
                          }

                          notetrackmovementgunposeoverride(var_0, var_1) {
                            self.asm.movementgunposeoverride = "run_gun_down";
                          }

                          notetrackalertnessaiming(var_0, var_1) {}

                          notetrackalertnesscasual(var_0, var_1) {}

                          notetrackalertnessalert(var_0, var_1) {}

                          stoponback() {
                            scripts\anim\utility::exitpronewrapper(1);
                            self.a.onback = undefined;
                          }

                          setpose(var_0) {
                            self.a.pose = var_0;
                            if(isDefined(self.a.onback)) {
                              stoponback();
                            }

                            scripts\asm\asm_bb::bb_requestsmartobject(var_0);
                            self notify("entered_pose" + var_0);
                          }

                          notetrackposestand(var_0, var_1) {
                            if(self.a.pose == "prone") {
                              scripts\anim\utility::exitpronewrapper(1);
                            }

                            setpose("stand");
                          }

                          notetrackposecrouch(var_0, var_1) {
                            if(self.a.pose == "prone") {
                              scripts\anim\utility::exitpronewrapper(1);
                            }

                            setpose("crouch");
                          }

                          notetrackposeprone(var_0, var_1) {
                            if(!issentient(self)) {
                              return;
                            }

                            self give_run_perk(-45, 45, % prone_legs_down, % exposed_aiming, % prone_legs_up);
                            scripts\anim\utility::enterpronewrapper(1);
                            setpose("prone");
                            if(isDefined(self.a._meth_8445)) {
                              self.a.proneaiming = 1;
                              return;
                            }

                            self.a.proneaiming = undefined;
                          }

                          notetrackposecrawl(var_0, var_1) {
                            if(!issentient(self)) {
                              return;
                            }

                            self give_run_perk(-45, 45, % prone_legs_down, % exposed_aiming, % prone_legs_up);
                            scripts\anim\utility::enterpronewrapper(1);
                            setpose("prone");
                            self.a.proneaiming = undefined;
                          }

                          notetrackposeback(var_0, var_1) {
                            if(!issentient(self)) {
                              return;
                            }

                            setpose("crouch");
                            self.a.onback = 1;
                            self.a.movement = "stop";
                            self give_run_perk(-90, 90, % prone_legs_down, % exposed_aiming, % prone_legs_up);
                            scripts\anim\utility::enterpronewrapper(1);
                          }

                          notetrackgunhand(var_0, var_1) {
                            if(issubstr(var_0, "left")) {
                              scripts\anim\shared::placeweaponon(self.var_394, "left");
                              self notify("weapon_switch_done");
                              return;
                            }

                            if(issubstr(var_0, "right")) {
                              scripts\anim\shared::placeweaponon(self.var_394, "right");
                              self notify("weapon_switch_done");
                              return;
                            }

                            if(issubstr(var_0, "none")) {
                              scripts\anim\shared::placeweaponon(self.var_394, "none");
                              return;
                            }
                          }

                          notetrackgundrop(var_0, var_1) {
                            scripts\anim\shared::func_5D19();
                            self._blackboard.var_26C6 = 0;
                            self.lastweapon = self.var_394;
                          }

                          notetrackguntochest(var_0, var_1) {
                            scripts\anim\shared::placeweaponon(self.var_394, "chest");
                          }

                          notetrackguntoback(var_0, var_1) {
                            scripts\anim\shared::placeweaponon(self.var_394, "back");
                            self.var_394 = scripts\anim\utility::detachall();
                            self.bulletsinclip = weaponclipsize(self.var_394);
                          }

                          notetrackpistolpickup(var_0, var_1) {
                            scripts\anim\shared::placeweaponon(self.var_101B4, "right");
                            self.bulletsinclip = weaponclipsize(self.var_394);
                            self notify("weapon_switch_done");
                          }

                          notetrackpistolputaway(var_0, var_1) {
                            if(isDefined(self.var_110CB)) {
                              scripts\anim\shared::placeweaponon(self.var_394, "thigh");
                            } else {
                              scripts\anim\shared::placeweaponon(self.var_394, "none");
                            }

                            self.var_394 = scripts\anim\utility::detachall();
                            self.bulletsinclip = weaponclipsize(self.var_394);
                          }

                          notetrackdropclip(var_0, var_1) {
                            thread scripts\anim\shared::handledropclip(var_1);
                          }

                          notetrackrefillclip(var_0, var_1) {
                            scripts\anim\weaponlist::refillclip();
                            self.a.needstorechamber = 0;
                          }

                          notetrackloadshell(var_0, var_1) {
                            self playSound("weap_reload_shotgun_loop_npc");
                          }

                          notetrackpistolrechamber(var_0, var_1) {
                            self playSound("weap_reload_pistol_chamber_npc");
                          }

                          notetrackgravity(var_0, var_1) {
                            if(issubstr(var_0, "on")) {
                              self animmode("gravity");
                              return;
                            }

                            if(issubstr(var_0, "off")) {
                              self animmode("nogravity");
                            }
                          }

                          notetrackfootstep(var_0, var_1) {
                            var_2 = issubstr(var_0, "left");
                            var_3 = issubstr(var_0, "large");
                            var_4 = "right";
                            if(var_2) {
                              var_4 = "left";
                            }

                            if(isai(self)) {
                              self.asm.footsteps.foot = var_4;
                              self.asm.footsteps.time = gettime();
                            }

                            if(scripts\asm\asm_bb::ispartdismembered("left_leg") || scripts\asm\asm_bb::ispartdismembered("right_leg")) {
                              return;
                            }

                            playfootstep(var_2, var_3);
                            var_5 = get_notetrack_movement();
                            if(isDefined(self.classname) && self.classname != "script_model") {
                              self _meth_8584(var_5);
                              if(isDefined(self.var_394)) {
                                var_6 = self _meth_8583(var_5, self.var_394);
                              }
                            }
                          }

                          notetrackhandstep(var_0, var_1) {
                            var_2 = issubstr(var_0, "left");
                            var_3 = issubstr(var_0, "large");
                            var_4 = "right";
                            if(var_2) {
                              var_4 = "left";
                            }

                            if(isai(self)) {
                              self.asm.footsteps.foot = var_4;
                              self.asm.footsteps.time = gettime();
                            }

                            func_D492(var_2, var_3);
                          }

                          get_notetrack_movement() {
                            var_0 = "run";
                            if(isDefined(self.var_10AB7)) {
                              var_0 = "sprint";
                            }

                            if(isDefined(self._blackboard)) {
                              if(self._blackboard.movetype == "walk" || self._blackboard.movetype == "casual_gun" || self._blackboard.movetype == "patrol" || self._blackboard.movetype == "casual") {
                                var_0 = "walk";
                              }

                              if(scripts\asm\asm_bb::func_292C() == "prone") {
                                var_0 = "prone";
                              }
                            } else if(isDefined(self.a)) {
                              if(isDefined(self.a.movement)) {
                                if(self.a.movement == "walk") {
                                  var_0 = "walk";
                                }
                              }

                              if(isDefined(self.a.pose)) {
                                if(self.a.pose == "prone") {
                                  var_0 = "prone";
                                }
                              }
                            }

                            return var_0;
                          }

                          notetrackspacejet(var_0, var_1) {
                            thread notetrackspacejet_proc(var_0, var_1);
                          }

                          notetrackspacejet_proc(var_0, var_1) {
                            self endon("death");
                            var_2 = [];
                            var_3 = undefined;
                            switch (var_0) {
                              case "space_jet_bottom":
                                var_2 = ["tag_jet_bottom_1", "tag_jet_bottom_2"];
                                break;

                              case "space_jet_bottom_1":
                                var_2 = ["tag_jet_bottom_1"];
                                break;

                              case "space_jet_bottom_2":
                                var_2 = ["tag_jet_bottom_2"];
                                break;

                              case "space_jet_top":
                                var_2 = ["tag_jet_top_1", "tag_jet_top_2"];
                                break;

                              case "space_jet_top_1":
                                var_2 = ["tag_jet_top_1"];
                                break;

                              case "space_jet_top_2":
                                var_2 = ["tag_jet_top_2"];
                                break;

                              case "space_jet_left":
                                var_2 = ["tag_jet_le_1", "tag_jet_le_2"];
                                break;

                              case "space_jet_left_1":
                                var_2 = ["tag_jet_le_1"];
                                break;

                              case "space_jet_left_2":
                                var_2 = ["tag_jet_le_2"];
                                break;

                              case "space_jet_right":
                                var_2 = ["tag_jet_ri_1", "tag_jet_ri_2"];
                                break;

                              case "space_jet_right_1":
                                var_2 = ["tag_jet_ri_1"];
                                break;

                              case "space_jet_right_2":
                                var_2 = ["tag_jet_ri_2"];
                                break;

                              case "space_jet_front":
                                var_2 = ["tag_jet_front_1", "tag_jet_front_2"];
                                break;

                              case "space_jet_front_1":
                                var_2 = ["tag_jet_front_1"];
                                break;

                              case "space_jet_front_2":
                                var_2 = ["tag_jet_front_2"];
                                break;

                              case "space_jet_back":
                                var_2 = ["tag_jet_back_1", "tag_jet_back_2", "tag_jet_back_3", "tag_jet_back_4"];
                                break;

                              case "space_jet_back_1":
                                var_2 = ["tag_jet_back_1"];
                                break;

                              case "space_jet_back_2":
                                var_2 = ["tag_jet_back_2"];
                                break;

                              case "space_jet_back_3":
                                var_2 = ["tag_jet_back_3"];
                                break;

                              case "space_jet_back_4":
                                var_2 = ["tag_jet_back_4"];
                                break;

                              case "space_jet_random":
                                var_2 = ["tag_jet_bottom_1", "tag_jet_bottom_2", "tag_jet_top_1", "tag_jet_top_2", "tag_jet_le_1", "tag_jet_le_2", "tag_jet_ri_1", "tag_jet_ri_2"];
                                break;
                            }

                            if(scripts\engine\utility::fxexists("space_jet_small") && isDefined(var_2)) {
                              if(isDefined(var_2)) {
                                if(var_0 == "space_jet_random") {
                                  for(var_4 = 0; var_4 < 6; var_4++) {
                                    var_5 = randomint(8);
                                    var_6 = var_2[var_5];
                                    if(scripts\sp\utility::hastag(self.model, var_6)) {
                                      if(!isDefined(self.var_25C8)) {
                                        self.var_25C8 = 0;
                                      }

                                      self.var_25C8++;
                                      if(self.var_25C8 > 5) {
                                        self.var_25C8 = 0;
                                      }

                                      if(self.var_25C8 == 1) {
                                        self playSound("space_npc_jetpack_boost_ss");
                                      }

                                      playFXOnTag(level._effect["space_jet_small"], self, var_6);
                                    }

                                    wait(randomfloatrange(0.1, 0.3));
                                  }

                                  return;
                                }

                                foreach(var_6 in var_3) {
                                  if(isDefined(var_6) && scripts\sp\utility::hastag(self.model, var_6)) {
                                    if(!isDefined(self.var_25C8)) {
                                      self.var_25C8 = 0;
                                    }

                                    self.var_25C8++;
                                    if(self.var_25C8 > 5) {
                                      self.var_25C8 = 0;
                                    }

                                    if(self.var_25C8 == 1) {
                                      self playSound("space_npc_jetpack_boost_ss");
                                    }

                                    playFXOnTag(level._effect["space_jet_small"], self, var_6);
                                    wait(0.1);
                                  }
                                }

                                return;
                              }
                            }
                          }

                          notetrackvisorraise(var_0, var_1) {
                            if(!isai(self)) {
                              return;
                            }

                            self.asm.var_DC48 = 1;
                            lib_0A1E::func_236E();
                          }

                          notetrackvisorlower(var_0, var_1) {
                            if(!isai(self)) {
                              return;
                            }

                            self.asm.var_DC48 = 0;
                            lib_0A1E::func_236E();
                          }

                          notetrackfingerposeoffleft(var_0, var_1) {
                            lib_0A1E::func_2319("left");
                          }

                          notetrackfingerposeonleft(var_0, var_1) {
                            lib_0A1E::func_234C("left");
                          }

                          notetrackfingerposeoffright(var_0, var_1) {
                            lib_0A1E::func_2319("left");
                          }

                          notetrackfingerposeonright(var_0, var_1) {
                            lib_0A1E::func_234C("right");
                          }

                          notetrackfacialidle(var_0, var_1) {
                            lib_0A1E::func_236A("facial_idle");
                          }

                          notetrackfacialrun(var_0, var_1) {
                            lib_0A1E::func_236A("facial_run");
                          }

                          notetrackfacialpain(var_0, var_1) {
                            lib_0A1E::func_236A("facial_pain");
                          }

                          notetrackfacialdeath(var_0, var_1) {
                            lib_0A1E::func_236A("facial_death");
                          }

                          notetrackfacialtalk(var_0, var_1) {
                            lib_0A1E::func_236A("facial_talk");
                          }

                          notetrackfacialcheer(var_0, var_1) {
                            lib_0A1E::func_236A("facial_cheer");
                          }

                          notetrackfacialhappy(var_0, var_1) {
                            lib_0A1E::func_236A("facial_happy");
                          }

                          notetrackfacialscared(var_0, var_1) {
                            lib_0A1E::func_236A("facial_scared");
                          }

                          notetrackfacialangry(var_0, var_1) {
                            lib_0A1E::func_236A("facial_angry");
                          }

                          customnotetrackfx(var_0, var_1) {
                            if(isDefined(self.pausemayhem)) {
                              var_2 = self.pausemayhem;
                            } else {
                              var_2 = "dirt";
                            }

                            var_3 = undefined;
                            if(isDefined(level._notetrackfx[var_0][var_2])) {
                              var_3 = level._notetrackfx[var_0][var_2];
                            } else if(isDefined(level._notetrackfx[var_0]["all"])) {
                              var_3 = level._notetrackfx[var_0]["all"];
                            }

                            if(!isDefined(var_3)) {
                              return;
                            }

                            if(isai(self) && isDefined(var_3.fx)) {
                              playFXOnTag(var_3.fx, self, var_3.physics_setgravitydynentscalar);
                            }

                            if(!isDefined(var_3.sound_prefix) && !isDefined(var_3.sound_suffix)) {
                              return;
                            }

                            var_4 = "" + var_3.sound_prefix + var_2 + var_3.sound_suffix;
                            if(soundexists(var_4)) {
                              self playSound(var_4);
                            }
                          }

                          notetrackfootscrape(var_0, var_1) {
                            if(isDefined(self.pausemayhem)) {
                              var_2 = self.pausemayhem;
                            } else {
                              var_2 = "dirt";
                            }

                            self playsurfacesound("step_scrape", var_2);
                          }

                          notetrackland(var_0, var_1) {
                            if(isDefined(self.pausemayhem)) {
                              var_2 = self.pausemayhem;
                            } else {
                              var_2 = "dirt";
                            }

                            self playsurfacesound("default_step_land", var_2);
                            self _meth_8584("land");
                            self _meth_8583("land", self.var_394);
                          }

                          notetrackcodemove(var_0, var_1) {
                            return "code_move";
                          }

                          notetrackfaceenemy(var_0, var_1) {
                            if(self.script != "reactions") {
                              self orientmode("face enemy");
                              return;
                            }

                            if(isDefined(self.isnodeoccupied) && distancesquared(self.isnodeoccupied.origin, self.getreflectionlocs) < 4096) {
                              self orientmode("face enemy");
                              return;
                            }

                            self orientmode("face point", self.getreflectionlocs);
                          }

                          notetrackbodyfall(var_0, var_1) {
                            var_2 = "_small";
                            if(issubstr(var_0, "large")) {
                              var_2 = "_large";
                            }

                            if(isDefined(self.pausemayhem)) {
                              var_3 = self.pausemayhem;
                            } else {
                              var_3 = "dirt";
                            }

                            if(soundexists("bodyfall_" + var_3 + var_2)) {
                              self playSound("bodyfall_" + var_3 + var_2);
                            }
                          }

                          handlerocketlauncherammoondeath() {
                            self endon("detached");
                            self waittill("death");
                            if(isDefined(self.rocketlauncherammo)) {
                              self.rocketlauncherammo delete();
                            }
                          }

                          notetrackrocketlauncherammoattach() {
                            if(!isalive(self)) {
                              return;
                            }

                            if(!scripts\anim\utility_common::usingrocketlauncher()) {
                              return;
                            }

                            self.rocketlauncherammo = spawn("script_model", self.origin);
                            if(issubstr(tolower(self.var_394), "lockon")) {
                              self.rocketlauncherammo setModel("weapon_launcher_missile_wm");
                            } else if(issubstr(tolower(self.var_394), "panzerfaust")) {
                              self.rocketlauncherammo setModel("weapon_panzerfaust3_missle");
                            } else {
                              self.rocketlauncherammo setModel("projectile_rpg7");
                            }

                            self.rocketlauncherammo linkto(self, "tag_accessory_right", (0, 0, 0), (0, 0, 0));
                            thread handlerocketlauncherammoondeath();
                          }

                          notetrackrocketlauncherammodelete() {
                            self notify("detached");
                            if(isDefined(self.rocketlauncherammo)) {
                              self.rocketlauncherammo delete();
                            }

                            self.a.rocketvisible = 1;
                            if(isai(self) && !isalive(self)) {
                              return;
                            }

                            if(scripts\sp\utility::hastag(getweaponmodel(self.var_394), "tag_rocket")) {
                              self giveperk("tag_rocket");
                            }
                          }

                          handlenotetrack(var_0, var_1, var_2, var_3) {
                            var_4 = level.notetracks[var_0];
                            if(isDefined(var_4)) {
                              return [
                                [var_4]
                              ](var_0, var_1);
                            } else if(isDefined(self.var_4C93)) {
                              if(isDefined(var_3)) {
                                return [
                                  [self.var_4C93]
                                ](var_0, var_1, var_2, var_3);
                              } else {
                                return [
                                  [self.var_4C93]
                                ](var_0, var_1, var_2);
                              }
                            }

                            switch (var_0) {
                              case "undefined":
                              case "finish":
                              case "end":
                                return var_0;

                              case "finish early":
                                if(isDefined(self.isnodeoccupied)) {
                                  return var_0;
                                }
                                break;

                              case "swish small":
                                thread scripts\engine\utility::play_sound_in_space("melee_swing_small", self gettagorigin("TAG_WEAPON_RIGHT"));
                                break;

                              case "swish large":
                                thread scripts\engine\utility::play_sound_in_space("melee_swing_large", self gettagorigin("TAG_WEAPON_RIGHT"));
                                break;

                              case "rechamber":
                                if(scripts\anim\utility_common::weapon_pump_action_shotgun()) {
                                  self playSound("weap_reload_shotgun_pump_npc");
                                }

                                self.a.needstorechamber = 0;
                                break;

                              case "no death":
                                self.a.nodeath = 1;
                                break;

                              case "no pain":
                                self.allowpain = 0;
                                break;

                              case "allow pain":
                                self.allowpain = 1;
                                break;

                              case "anim_melee = \"right\":
                              case "anim_melee = right":
                                self.a.meleestate = "right";
                                break;

                              case "anim_melee = \"left\":
                              case "anim_melee = left":
                                self.a.meleestate = "left";
                                break;

                              case "swap taghelmet to tagleft":
                                if(isDefined(self.hatmodel)) {
                                  if(isDefined(self.helmetsidemodel)) {
                                    self detach(self.helmetsidemodel, "TAG_HELMETSIDE");
                                    self.helmetsidemodel = undefined;
                                  }

                                  self detach(self.hatmodel, "");
                                  self attach(self.hatmodel, "TAG_WEAPON_LEFT");
                                  self.hatmodel = undefined;
                                }
                                break;

                              case "stop anim":
                                scripts\sp\utility::anim_stopanimscripted();
                                return var_0;

                              case "break glass":
                                level notify("glass_break", self);
                                break;

                              case "break_glass":
                                level notify("glass_break", self);
                                break;

                              case "attach clip left":
                                if(scripts\anim\utility_common::usingrocketlauncher()) {
                                  notetrackrocketlauncherammoattach();
                                }
                                break;

                              case "detach clip left":
                                if(scripts\anim\utility_common::usingrocketlauncher()) {
                                  notetrackrocketlauncherammodelete();
                                }
                                break;

                              case "jetpack_boost":
                                thread func_CCAB("boost_on_up", "large");
                                break;

                              case "boost_on_right":
                              case "boost_on_left":
                              case "boost_on_down":
                              case "boost_on_back":
                              case "boost_on_forward":
                              case "boost_on_up":
                                thread func_CCAB(var_0, "large");
                                break;

                              case "boost_on_right_short":
                              case "boost_on_left_short":
                              case "boost_on_down_short":
                              case "boost_on_up_short":
                              case "boost_on_back_short":
                              case "boost_on_forward_short":
                                func_CCAB(var_0, "small");
                                break;

                              case "jetpack_death_fx":
                                playFXOnTag(scripts\engine\utility::getfx("zerog_jetpack_death"), self, "tag_fx_bottom");
                                break;

                              case "start_drift":
                                if(!self.logstring) {
                                  self animmode("physics_drift");
                                }
                                break;

                              case "c6_punch":
                                self playSound("c6_punch");
                                break;

                              default:
                                if(isDefined(var_2)) {
                                  if(isDefined(var_3)) {
                                    return [
                                      [var_2]
                                    ](var_0, var_3);
                                  } else {
                                    return [
                                      [var_2]
                                    ](var_0);
                                  }
                                }
                                break;
                            }
                          }

                          donotetracksintercept(var_0, var_1, var_2) {
                            for(;;) {
                              self waittill(var_0, var_3);
                              if(!isDefined(var_3)) {
                                var_3 = ["undefined"];
                              }

                              if(!isarray(var_3)) {
                                var_3 = [var_3];
                              }

                              scripts\anim\utility::validatenotetracks(var_0, var_3);
                              var_4 = [
                                [var_1]
                              ](var_3);
                              if(isDefined(var_4) && var_4) {
                                continue;
                              }

                              var_5 = undefined;
                              foreach(var_7 in var_3) {
                                var_8 = handlenotetrack(var_7, var_0);
                                if(isDefined(var_8)) {
                                  var_5 = var_8;
                                  break;
                                }
                              }

                              if(isDefined(var_5)) {
                                return var_5;
                              }
                            }
                          }

                          donotetrackspostcallback(var_0, var_1) {
                            for(;;) {
                              self waittill(var_0, var_2);
                              if(!isDefined(var_2)) {
                                var_2 = ["undefined"];
                              }

                              if(!isarray(var_2)) {
                                var_2 = [var_2];
                              }

                              scripts\anim\utility::validatenotetracks(var_0, var_2);
                              var_3 = undefined;
                              foreach(var_5 in var_2) {
                                var_6 = handlenotetrack(var_5, var_0);
                                if(isDefined(var_6)) {
                                  var_3 = var_6;
                                  break;
                                }
                              }

                              [[var_1]](var_2);
                              if(isDefined(var_3)) {
                                return var_3;
                              }
                            }
                          }

                          donotetracksfortimeout(var_0, var_1, var_2, var_3) {
                            scripts\anim\shared::donotetracks(var_0, var_2, var_3);
                          }

                          donotetracksforever(var_0, var_1, var_2, var_3) {
                            donotetracksforeverproc(::scripts\anim\shared::donotetracks, var_0, var_1, var_2, var_3);
                          }

                          donotetracksforeverintercept(var_0, var_1, var_2, var_3) {
                            donotetracksforeverproc(::donotetracksintercept, var_0, var_1, var_2, var_3);
                          }

                          donotetracksforeverproc(var_0, var_1, var_2, var_3, var_4) {
                            if(isDefined(var_2)) {
                              self endon(var_2);
                            }

                            self endon("killanimscript");
                            if(!isDefined(var_4)) {
                              var_4 = "undefined";
                            }

                            for(;;) {
                              var_5 = gettime();
                              var_6 = [
                                [var_0]
                              ](var_1, var_3, var_4);
                              var_7 = gettime() - var_5;
                              if(var_7 < 0.05) {
                                var_5 = gettime();
                                var_6 = [
                                  [var_0]
                                ](var_1, var_3, var_4);
                                var_7 = gettime() - var_5;
                                if(var_7 < 0.05) {
                                  wait(0.05 - var_7);
                                }
                              }
                            }
                          }

                          donotetrackswithtimeout(var_0, var_1, var_2, var_3) {
                            var_4 = spawnStruct();
                            var_4 thread donotetracksfortimeendnotify(var_1);
                            donotetracksfortimeproc(::donotetracksfortimeout, var_0, var_2, var_3, var_4);
                          }

                          donotetracksfortime(var_0, var_1, var_2, var_3) {
                            var_4 = spawnStruct();
                            var_4 thread donotetracksfortimeendnotify(var_0);
                            donotetracksfortimeproc(::donotetracksforever, var_1, var_2, var_3, var_4);
                          }

                          donotetracksfortimeintercept(var_0, var_1, var_2, var_3) {
                            var_4 = spawnStruct();
                            var_4 thread donotetracksfortimeendnotify(var_0);
                            donotetracksfortimeproc(::donotetracksforeverintercept, var_1, var_2, var_3, var_4);
                          }

                          donotetracksfortimeproc(var_0, var_1, var_2, var_3, var_4) {
                            var_4 endon("stop_notetracks");
                            [
                              [var_0]
                            ](var_1, undefined, var_2, var_3);
                          }

                          donotetracksfortimeendnotify(var_0) {
                            wait(var_0);
                            self notify("stop_notetracks");
                          }

                          playfootstep(var_0, var_1) {
                            if(!isai(self)) {
                              self playsurfacesound("default_step_run", "dirt");
                              return;
                            }

                            var_2 = undefined;
                            if(!isDefined(self.pausemayhem)) {
                              if(!isDefined(self.var_A995)) {
                                self playsurfacesound("default_step_run", "dirt");
                                return;
                              }

                              var_2 = self.var_A995;
                            } else {
                              var_2 = self.pausemayhem;
                              self.var_A995 = self.pausemayhem;
                            }

                            var_3 = "J_Ball_RI";
                            if(var_0) {
                              var_3 = "J_Ball_LE";
                            }

                            var_4 = get_notetrack_movement();
                            if(self.unittype == "soldier" || self.unittype == "civilian") {
                              var_5 = "";
                            } else {
                              var_5 = tolower(self.unittype + "_");
                            }

                            if(self.unittype == "c6i" || self.unittype == "c6" || self.unittype == "c8" || self.unittype == "c12") {
                              var_6 = var_5 + "step_" + var_4;
                            } else {
                              var_6 = var_6 + "default_step_" + var_5;
                            }

                            if(soundexists(var_6)) {
                              if(self.unittype == "c8") {
                                if(!isDefined(self.var_6BC7)) {
                                  self.var_6BC7 = spawn("script_origin", self.origin);
                                  self.var_6BC7 linkto(self);
                                }

                                self.var_6BC7 playsurfacesound(var_6, var_2);
                              } else {
                                thread scripts\sp\utility::func_CE48(var_6, var_2, var_3);
                              }
                            }

                            if(isDefined(self.var_164D[self.asmname].var_4BC0)) {
                              if(issubstr(self.var_164D[self.asmname].var_4BC0, "wall_run")) {
                                self playSound("wall_run_tech_lyr_npc");
                              }

                              if(self.unittype == "c8" && self.var_164D[self.asmname].var_4BC0 == "melee_charge") {
                                thread scripts\sp\utility::play_sound_on_tag("c8_step_charge_lyr", var_3);
                              }
                            }

                            if(self.unittype == "c12") {
                              var_7 = "c12_footstep_small";
                              var_8 = 450;
                              var_9 = 0.3;
                              if(var_4 == "run") {
                                var_7 = "c12_footstep_large";
                                var_9 = 0.5;
                                var_8 = 900;
                              }

                              self playrumbleonentity(var_7);
                              screenshake(self.origin, var_9, var_9, var_9, 0.3, 0, -1, var_8, 5, 0.2, 2);
                              var_0A = self gettagorigin(var_3);
                              var_0B = self.angles;
                              var_0C = anglestoup(var_0B);
                              var_0C = var_0C * 0.35;
                              physicsjolt(var_0A, 50, 25, var_0C);
                              var_0D = 100;
                              if(!level.player isjumping() && distancesquared(level.player.origin, var_0A) <= squared(var_0D)) {
                                level.player dodamage(level.player.maxhealth * 0.5, var_0A, self);
                                level.player viewkick(1, var_0A, 0);
                                var_0E = vectornormalize(level.player.origin - var_0A);
                                level.player setvelocity(150 * var_0E);
                              }
                            }

                            if(var_1) {
                              if(![
                                  [level.optionalstepeffectfunction]
                                ](var_3, var_2)) {
                                func_D480(var_3, var_2);
                                return;
                              }

                              return;
                            }

                            if(![
                                [level.optionalstepeffectsmallfunction]
                              ](var_3, var_2)) {
                              playfootstepeffect(var_3, var_2);
                            }
                          }

                          func_D492(var_0, var_1) {
                            if(!isai(self)) {
                              self playsurfacesound("c6_handstep", "default");
                              return;
                            }

                            if(var_0) {
                              var_2 = "J_MID_LE_1";
                              if(lib_0A0B::func_7C35("left_arm") == "dismember") {
                                return;
                              }
                            } else {
                              var_2 = "J_MID_RI_1";
                              if(lib_0A0B::func_7C35("right_arm") == "dismember") {
                                return;
                              }
                            }

                            var_3 = undefined;
                            if(!isDefined(self.pausemayhem)) {
                              if(!isDefined(self.var_A995)) {
                                self playsurfacesound("c6_handstep", "default");
                                return;
                              }

                              var_3 = self.var_A995;
                            } else {
                              var_3 = self.pausemayhem;
                              self.var_A995 = self.pausemayhem;
                            }

                            var_4 = get_notetrack_movement();
                            var_5 = "c6_handstep";
                            if(soundexists(var_5)) {
                              self playsurfacesound(var_5, var_3);
                            }

                            if(![
                                [level.optionalstepeffectsmallfunction]
                              ](var_2, var_3)) {
                              playfootstepeffect(var_2, var_3);
                            }
                          }

                          playfootstepeffect(var_0, var_1) {
                            if(!isDefined(level.optionalstepeffects[var_1])) {
                              return 0;
                            }

                            var_2 = self gettagorigin(var_0);
                            var_3 = self.angles;
                            var_4 = anglesToForward(var_3);
                            var_5 = anglestoup(var_3);
                            if(!isDefined(level._effect["step_" + var_1][self.unittype])) {
                              level._effect["step_" + var_1][self.unittype] = level._effect["step_" + var_1]["soldier"];
                            }

                            playFX(level._effect["step_" + var_1][self.unittype], var_2, var_4, var_5);
                            return 1;
                          }

                          func_D480(var_0, var_1) {
                            if(!isDefined(level.optionalstepeffectssmall[var_1])) {
                              return 0;
                            }

                            var_2 = self gettagorigin(var_0);
                            var_3 = self.angles;
                            var_4 = anglesToForward(var_3);
                            var_5 = anglestoup(var_3);
                            if(!isDefined(level._effect["step_small_" + var_1][self.unittype])) {
                              level._effect["step_small_" + var_1][self.unittype] = level._effect["step_small_" + var_1]["soldier"];
                            }

                            playFX(level._effect["step_small_" + var_1][self.unittype], var_2, var_4, var_5);
                            return 1;
                          }

                          fire_straight() {
                            if(self.a.weaponpos["right"] == "none") {
                              return;
                            }

                            if(isDefined(self.dontshootstraight)) {
                              shootnotetrack();
                              return;
                            }

                            if(scripts\sp\utility::hastag(self.model, "tag_weapon")) {
                              var_0 = self gettagorigin("tag_weapon");
                            } else {
                              var_0 = self gettagorigin("tag_weapon_right");
                            }

                            var_1 = anglesToForward(self getspawnpointdist());
                            var_2 = var_0 + var_1 * 1000;
                            self shoot(1, var_2);
                            scripts\anim\combat_utility::decrementbulletsinclip();
                          }

                          notetrackfirespray(var_0, var_1) {
                            if(!isalive(self) && self gettargetchargepos()) {
                              if(isDefined(self.var_3C55)) {
                                return;
                              }

                              self.var_3C55 = 1;
                              var_2["axis"] = "team3";
                              var_2["team3"] = "axis";
                              self.team = var_2[self.team];
                            }

                            if(!issentient(self)) {
                              self notify("fire");
                              return;
                            }

                            if(self.a.weaponpos["right"] == "none") {
                              return;
                            }

                            var_3 = self getmuzzlepos();
                            var_4 = anglesToForward(self getspawnpointdist());
                            var_5 = 10;
                            if(isDefined(self.var_9F15)) {
                              var_5 = 20;
                            }

                            var_6 = 0;
                            if(isalive(self.isnodeoccupied) && issentient(self.isnodeoccupied) && self canshootenemy()) {
                              var_7 = vectornormalize(self.isnodeoccupied getEye() - var_3);
                              if(vectordot(var_4, var_7) > cos(var_5)) {
                                var_6 = 1;
                              }
                            }

                            if(var_6) {
                              scripts\anim\utility_common::shootenemywrapper();
                            } else {
                              var_4 = var_4 + (randomfloat(2) - 1 * 0.1, randomfloat(2) - 1 * 0.1, randomfloat(2) - 1 * 0.1);
                              var_8 = var_3 + var_4 * 1000;
                              self[[level.var_FED3]](var_8);
                            }

                            scripts\anim\combat_utility::decrementbulletsinclip();
                          }

                          func_CCAB(var_0, var_1) {
                            var_2 = [];
                            if(var_0 == "boost_on_forward" || var_0 == "boost_on_forward_short") {
                              var_2[var_2.size] = "tag_fx_back";
                            } else if(var_0 == "boost_on_back" || var_0 == "boost_on_back_short") {
                              var_2[var_2.size] = "tag_fx_left";
                              var_2[var_2.size] = "tag_fx_right";
                            } else if(var_0 == "boost_on_up" || var_0 == "boost_on_up_short") {
                              var_2[var_2.size] = "tag_fx_bottom";
                            } else if(var_0 == "boost_on_down" || var_0 == "boost_on_down_short") {
                              var_2[var_2.size] = "tag_fx_top";
                            } else if(var_0 == "boost_on_left" || var_0 == "boost_on_left_short") {
                              var_2[var_2.size] = "tag_fx_right";
                            } else if(var_0 == "boost_on_right" || var_0 == "boost_on_right_short") {
                              var_2[var_2.size] = "tag_fx_left";
                            }

                            var_3 = undefined;
                            if(var_1 == "large") {
                              var_3 = scripts\engine\utility::ter_op(isDefined(level.var_E977), level.var_13EE8, ::func_CD6B);
                            } else if(var_1 == "small") {
                              var_3 = scripts\engine\utility::ter_op(isDefined(level.var_E977), level.var_13EE9, ::func_CE13);
                            }

                            foreach(var_5 in var_2) {
                              self[[var_3]](var_5);
                            }
                          }

                          func_CD6B(var_0) {
                            return func_CE37("jetpack_thruster_large", "jetpack_thruster_large_allies", var_0);
                          }

                          func_CE13(var_0) {
                            return func_CE37("jetpack_thruster_small", "jetpack_thruster_small_allies", var_0);
                          }

                          func_CE37(var_0, var_1, var_2) {
                            self endon("death");
                            if(self.team == "neutral") {
                              return undefined;
                            }

                            var_3 = self.team;
                            if(var_3 == "dead") {
                              var_3 = self.var_C733;
                            }

                            var_4 = undefined;
                            if(var_3 == "axis") {
                              var_4 = scripts\engine\utility::getfx(var_0);
                            } else if(var_3 == "allies") {
                              var_4 = scripts\engine\utility::getfx(var_1);
                            }

                            var_5 = scripts\engine\utility::ter_op(self.team == "axis", "double_jump_boost_enemy", "double_jump_boost_npc");
                            childthread scripts\sp\utility::play_sound_on_entity(var_5);
                            playFXOnTag(var_4, self, var_2);
                            return [var_4, var_2];
                          }