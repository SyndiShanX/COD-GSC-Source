/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_cbb0697de4c5728.gsc
***********************************************/

_id_3B59B4D385A202E6() {
  level._id_FB690B0442393F26 = [];
  level._id_F075B3A145F1C730 = [];
  level._id_7546F688873B4CE4 = [];
  level._id_15F270E2898482BE = [];
  level._id_D83CA3F3BDF5B3D4 = [];
  level._id_A3D1147A42B2FD91 = [];
  level._id_88C1332FB32E977C = [];
  level._id_E65F4101FD50A0E1 = [];
  level._id_1C6C766B95B77E8A = [];
  level._effect["youveBeenNaughty_limb"] = loadfx("vfx/iw9/core/weapons/impacts/mtx/vfx_imp_mtx_naughty_limb");
  level._effect["youveBeenNaughty_torso"] = loadfx("vfx/iw9/core/weapons/impacts/mtx/vfx_imp_mtx_naughty_torso");
  level._effect["youveBeenNaughty_head"] = loadfx("vfx/iw9/core/weapons/impacts/mtx/vfx_imp_mtx_naughty_head");
  level._effect["youveBeenNice_limb"] = loadfx("vfx/iw9/core/weapons/impacts/mtx/vfx_imp_mtx_nice_limb");
  level._effect["youveBeenNice_torso"] = loadfx("vfx/iw9/core/weapons/impacts/mtx/vfx_imp_mtx_nice_torso");
  level._effect["youveBeenNice_head"] = loadfx("vfx/iw9/core/weapons/impacts/mtx/vfx_imp_mtx_nice_head");
  level._effect["vDay_limb"] = loadfx("vfx/iw9/core/weapons/impacts/mtx/vfx_imp_mtx_vday_limb");
  level._effect["vDay_torso"] = loadfx("vfx/iw9/core/weapons/impacts/mtx/vfx_imp_mtx_vday_torso");
  level._effect["vDay_head"] = loadfx("vfx/iw9/core/weapons/impacts/mtx/vfx_imp_mtx_vday_head");
  level._effect["bCell_limb"] = loadfx("vfx/iw9/core/weapons/impacts/mtx/vfx_imp_mtx_bcell_limb");
  level._effect["bCell_torso"] = loadfx("vfx/iw9/core/weapons/impacts/mtx/vfx_imp_mtx_bcell_torso");
  level._effect["bCell_head"] = loadfx("vfx/iw9/core/weapons/impacts/mtx/vfx_imp_mtx_bcell_head");
  level._effect["bCell_nogore_limb"] = loadfx("vfx/iw9/core/weapons/impacts/mtx/vfx_imp_mtx_bcell_nogore_limb");
  level._effect["bCell_nogore_torso"] = loadfx("vfx/iw9/core/weapons/impacts/mtx/vfx_imp_mtx_bcell_nogore_torso");
  level._effect["bCell_nogore_head"] = loadfx("vfx/iw9/core/weapons/impacts/mtx/vfx_imp_mtx_bcell_nogore_head");
  level._effect["paddy_limb"] = loadfx("vfx/iw9/core/weapons/impacts/mtx/vfx_imp_paddy_limb");
  level._effect["paddy_torso"] = loadfx("vfx/iw9/core/weapons/impacts/mtx/vfx_imp_paddy_torso");
  level._effect["paddy_head"] = loadfx("vfx/iw9/core/weapons/impacts/mtx/vfx_imp_paddy_head");
  level._effect["easter_limb"] = loadfx("vfx/iw9/core/weapons/impacts/mtx/vfx_imp_mtx_easter_limb");
  level._effect["easter_torso"] = loadfx("vfx/iw9/core/weapons/impacts/mtx/vfx_imp_mtx_easter_torso");
  level._effect["easter_head"] = loadfx("vfx/iw9/core/weapons/impacts/mtx/vfx_imp_mtx_easter_head");
  level._effect["easter_nogore_limb"] = loadfx("vfx/iw9/core/weapons/impacts/mtx/vfx_imp_mtx_easter_nogore_limb");
  level._effect["easter_nogore_torso"] = loadfx("vfx/iw9/core/weapons/impacts/mtx/vfx_imp_mtx_easter_nogore_torso");
  level._effect["easter_nogore_head"] = loadfx("vfx/iw9/core/weapons/impacts/mtx/vfx_imp_mtx_easter_nogore_head");
  level._effect["scifi_limb"] = loadfx("vfx/iw9/core/weapons/impacts/mtx/vfx_imp_mtx_scifi_limb");
  level._effect["scifi_torso"] = loadfx("vfx/iw9/core/weapons/impacts/mtx/vfx_imp_mtx_scifi_torso");
  level._effect["scifi_head"] = loadfx("vfx/iw9/core/weapons/impacts/mtx/vfx_imp_mtx_scifi_head");
  level._effect["scifi_origin"] = loadfx("vfx/iw9/core/weapons/impacts/mtx/vfx_imp_mtx_scifi_death_mesh");
  level._effect["scifi2_limb"] = loadfx("vfx/iw9/core/weapons/impacts/mtx/vfx_imp_mtx_scifi2_limb");
  level._effect["scifi2_torso"] = loadfx("vfx/iw9/core/weapons/impacts/mtx/vfx_imp_mtx_scifi2_torso");
  level._effect["scifi2_head"] = loadfx("vfx/iw9/core/weapons/impacts/mtx/vfx_imp_mtx_scifi2_head");
  level._effect["scifi2_origin"] = loadfx("vfx/iw9/core/weapons/impacts/mtx/vfx_imp_mtx_scifi2_death_mesh");
  level._effect["scifi3_limb"] = loadfx("vfx/iw9/core/weapons/impacts/mtx/vfx_imp_mtx_scifi3_limb");
  level._effect["scifi3_torso"] = loadfx("vfx/iw9/core/weapons/impacts/mtx/vfx_imp_mtx_scifi3_torso");
  level._effect["scifi3_head"] = loadfx("vfx/iw9/core/weapons/impacts/mtx/vfx_imp_mtx_scifi3_head");
  level._effect["scifi3_origin"] = loadfx("vfx/iw9/core/weapons/impacts/mtx/vfx_imp_mtx_scifi3_death_mesh");
  level._effect["420_death"] = loadfx("vfx/iw9/core/weapons/impacts/mtx/vfx_imp_fatal_weed_sh");
  level._effect["hitscan"] = loadfx("vfx/iw9/core/weapons/impacts/mtx/vfx_imp_mtx_hitscan_fatal");
  level._effect["thor"] = loadfx("vfx/iw9/core/weapons/impacts/mtx/vfx_imp_mtx_thor_fatal");
  level._effect["thor_chest"] = loadfx("vfx/iw9/core/weapons/impacts/mtx/vfx_imp_mtx_thor_fatal_chest");
  level._effect["soulEater_limb"] = loadfx("vfx/iw9/core/weapons/impacts/mtx/vfx_imp_mtx_souleater_limb");
  level._effect["soulEater_torso"] = loadfx("vfx/iw9/core/weapons/impacts/mtx/vfx_imp_mtx_souleater_torso");
  level._effect["soulEater_head"] = loadfx("vfx/iw9/core/weapons/impacts/mtx/vfx_imp_mtx_souleater_head");
  level._effect["soulEater_death"] = loadfx("vfx/iw9/core/weapons/impacts/mtx/vfx_imp_mtx_soul_fatal");
  level._effect["crash_limb"] = loadfx("vfx/iw9/core/weapons/impacts/mtx/vfx_imp_mtx_crash_limb");
  level._effect["crash_torso"] = loadfx("vfx/iw9/core/weapons/impacts/mtx/vfx_imp_mtx_crash_torso");
  level._effect["crash_head"] = loadfx("vfx/iw9/core/weapons/impacts/mtx/vfx_imp_mtx_crash_head");
  level._effect["cthulhu_limb"] = loadfx("vfx/iw9/core/weapons/impacts/mtx/vfx_imp_mtx_cthulhu_limb");
  level._effect["cthulhu_torso"] = loadfx("vfx/iw9/core/weapons/impacts/mtx/vfx_imp_mtx_cthulhu_torso");
  level._effect["cthulhu_head"] = loadfx("vfx/iw9/core/weapons/impacts/mtx/vfx_imp_mtx_cthulhu_head");
  level._effect["cthulhu_nogore_limb"] = loadfx("vfx/iw9/core/weapons/impacts/mtx/vfx_imp_mtx_cthulhu_nogore_limb");
  level._effect["cthulhu_nogore_torso"] = loadfx("vfx/iw9/core/weapons/impacts/mtx/vfx_imp_mtx_cthulhu_nogore_torso");
  level._effect["cthulhu_nogore_head"] = loadfx("vfx/iw9/core/weapons/impacts/mtx/vfx_imp_mtx_cthulhu_nogore_head");
  level._effect["akihabara_fatal"] = loadfx("vfx/iw9/core/weapons/impacts/mtx/vfx_imp_akihabara_fatal");
  level._effect["hlander_limb"] = loadfx("vfx/iw9/core/weapons/impacts/mtx/vfx_imp_mtx_hlander_limb");
  level._effect["hlander_torso"] = loadfx("vfx/iw9/core/weapons/impacts/mtx/vfx_imp_mtx_hlander_torso");
  level._effect["hlander_head"] = loadfx("vfx/iw9/core/weapons/impacts/mtx/vfx_imp_mtx_hlander_head");
  level._effect["hlander_nogore_limb"] = loadfx("vfx/iw9/core/weapons/impacts/mtx/vfx_imp_mtx_hlander_nogore_limb");
  level._effect["hlander_nogore_torso"] = loadfx("vfx/iw9/core/weapons/impacts/mtx/vfx_imp_mtx_hlander_nogore_torso");
  level._effect["hlander_nogore_head"] = loadfx("vfx/iw9/core/weapons/impacts/mtx/vfx_imp_mtx_hlander_nogore_head");
  level._effect["nicki_limb"] = loadfx("vfx/iw9/core/weapons/impacts/mtx/vfx_imp_mtx_nicki_limb");
  level._effect["nicki_torso"] = loadfx("vfx/iw9/core/weapons/impacts/mtx/vfx_imp_mtx_nicki_torso");
  level._effect["nicki_head"] = loadfx("vfx/iw9/core/weapons/impacts/mtx/vfx_imp_mtx_nicki_head");
  level._effect["ice_limb"] = loadfx("vfx/iw9/core/weapons/impacts/mtx/vfx_imp_mtx_ice_limb");
  level._effect["ice_torso"] = loadfx("vfx/iw9/core/weapons/impacts/mtx/vfx_imp_mtx_ice_torso");
  level._effect["ice_head"] = loadfx("vfx/iw9/core/weapons/impacts/mtx/vfx_imp_mtx_ice_head");
  level._effect["ice_nogore_limb"] = loadfx("vfx/iw9/core/weapons/impacts/mtx/vfx_imp_mtx_ice_limb_nogore");
  level._effect["ice_nogore_torso"] = loadfx("vfx/iw9/core/weapons/impacts/mtx/vfx_imp_mtx_ice_torso_nogore");
  level._effect["tomb_limb"] = loadfx("vfx/iw9/core/weapons/impacts/mtx/lara/vfx_fatal_mtx_lara_limb");
  level._effect["tomb_torso"] = loadfx("vfx/iw9/core/weapons/impacts/mtx/lara/vfx_fatal_mtx_lara_torso");
  level._effect["tomb_head"] = loadfx("vfx/iw9/core/weapons/impacts/mtx/lara/vfx_fatal_mtx_lara_head");
  level._effect["tomb_limb_nogore"] = loadfx("vfx/iw9/core/weapons/impacts/mtx/lara/vfx_fatal_mtx_lara_limb_nogore");
  level._effect["tomb_torso_nogore"] = loadfx("vfx/iw9/core/weapons/impacts/mtx/lara/vfx_fatal_mtx_lara_torso_nogore");
  level._effect["tomb_head_nogore"] = loadfx("vfx/iw9/core/weapons/impacts/mtx/lara/vfx_fatal_mtx_lara_head_nogore");
  level._effect["tomb_limb"] = loadfx("vfx/iw9/core/weapons/impacts/mtx/lara/vfx_fatal_mtx_lara_limb");
  level._effect["tomb_torso"] = loadfx("vfx/iw9/core/weapons/impacts/mtx/lara/vfx_fatal_mtx_lara_torso");
  level._effect["tomb_head"] = loadfx("vfx/iw9/core/weapons/impacts/mtx/lara/vfx_fatal_mtx_lara_head");
  level._effect["hips_limb"] = loadfx("vfx/iw9/core/weapons/impacts/mtx/vfx_imp_mtx_hips_limb");
  level._effect["hips_torso"] = loadfx("vfx/iw9/core/weapons/impacts/mtx/vfx_imp_mtx_hips_torso");
  level._effect["hips_head"] = loadfx("vfx/iw9/core/weapons/impacts/mtx/vfx_imp_mtx_hips_head");
  level._effect["hops_limb"] = loadfx("vfx/iw9/core/weapons/impacts/mtx/vfx_imp_mtx_hops_limb");
  level._effect["hops_torso"] = loadfx("vfx/iw9/core/weapons/impacts/mtx/vfx_imp_mtx_hops_torso");
  level._effect["hops_head"] = loadfx("vfx/iw9/core/weapons/impacts/mtx/vfx_imp_mtx_hops_head");
  level._effect["maze_limb"] = loadfx("vfx/iw9/core/weapons/impacts/mtx/vfx_imp_mtx_maze_limb");
  level._effect["maze_torso"] = loadfx("vfx/iw9/core/weapons/impacts/mtx/vfx_imp_mtx_maze_torso");
  level._effect["maze_head"] = loadfx("vfx/iw9/core/weapons/impacts/mtx/vfx_imp_mtx_maze_head");
  level._effect["maze_nogore_limb"] = loadfx("vfx/iw9/core/weapons/impacts/mtx/vfx_imp_mtx_maze_nogore_limb");
  level._effect["maze_nogore_torso"] = loadfx("vfx/iw9/core/weapons/impacts/mtx/vfx_imp_mtx_maze_nogore_torso");
  level._effect["maze_nogore_head"] = loadfx("vfx/iw9/core/weapons/impacts/mtx/vfx_imp_mtx_maze_nogore_head");
  level._effect["bcell6_limb"] = loadfx("vfx/iw9/core/operators/reactive/bcell6/vfx_mtx_fatal_explode_limb_bcell6");
  level._effect["bcell6_torso"] = loadfx("vfx/iw9/core/operators/reactive/bcell6/vfx_mtx_fatal_explode_torso_bcell6");
  level._effect["bcell6_head"] = loadfx("vfx/iw9/core/operators/reactive/bcell6/vfx_mtx_fatal_explode_head_bcell6");
  level._effect["lilith"] = loadfx("vfx/iw9/core/weapons/impacts/mtx/vfx_imp_mtx_lilith_fatal");
  level._effect["inarius"] = loadfx("vfx/iw9/core/weapons/impacts/mtx/vfx_imp_mtx_inarius_fatal");
  level._effect["witch"] = loadfx("vfx/iw9/core/weapons/impacts/mtx/witch_s6/vfx_imp_witch_fatal.vfx");
  level._effect["zombie"] = loadfx("vfx/iw9/core/weapons/impacts/mtx/zombie_s6/vfx_imp_zombie_fatal.vfx");

  if(getdvarint("mgl", 0) != 0) {
    level._effect["sbandit_fatal"] = loadfx("vfx/mgl/iw9/core/weapons/impacts/mtx/vfx_imp_flesh_ftl_bdt");
    level._effect["spider_fatal"] = loadfx("vfx/mgl/iw9/core/weapons/impacts/mtx/vfx_death_mtx_alpha50_spider");
    level._effect["spaceignition_fatal"] = loadfx("vfx/mgl/iw9/core/weapons/impacts/mtx/vfx_imp_flesh_fatal_spaceIgnition");
    level._effect["arcstorm_fatal"] = loadfx("vfx/mgl/iw9/core/weapons/impacts/mtx/vfx_death_mtx_mike4_arcstorm");
    level._effect["slatedprism_fatal"] = loadfx("vfx/mgl/iw9/core/weapons/impacts/mtx/vfx_imp_mtx_slatedprism_fatal");
    level._effect["crytempest_fatal"] = loadfx("vfx/mgl/iw9/core/weapons/impacts/mtx/vfx_imp_mtx_crystal_tempest_fatal");
    level._effect["cyberviking_fatal"] = loadfx("vfx/mgl/iw9/core/weapons/impacts/mtx/vfx_imp_flesh_fatal_cyber_viking");
    level._effect["banshee_fatal"] = loadfx("vfx/mgl/iw9/core/weapons/impacts/mtx/vfx_imp_flesh_fatal_banshee");
  }

  _id_308F735A299221E3("stat_B822C8DA683933C3", ::_id_036F3C1F20204B13);
  _id_308F735A299221E3("stat_DF9C7E505CB8051E", ::_id_777C1F2E7F15D92E);
  _id_308F735A299221E3("stat_6ECDFF01066F53A1", ::_id_337B80F7FF25B0C9);
  _id_308F735A299221E3("stat_677C0D23EBBF0F57", ::_id_F7BCA22A37224D8B);
  _id_308F735A299221E3("stat_205C238F294F2AB5", ::_id_1A406EDD298ED8AD);
  _id_308F735A299221E3("stat_B57D05A770BC3269", ::_id_583F9260E6221231);
  _id_308F735A299221E3("stat_8BD73626076585E0", ::_id_1B5DFB950D2E6DD2);
  _id_308F735A299221E3("stat_6985A8D2DE65A0AC", ::_id_0436125459CF039E);
  _id_308F735A299221E3("stat_2D9F61F3374744A8", ::_id_0103D412A4079B9A);
  _id_308F735A299221E3("stat_7F02AD5BAC60414E", ::_id_731555C8BF961FAE);
  _id_308F735A299221E3("stat_094384C6D87383D7", ::_id_4A614A5BCB3B50CB);
  _id_308F735A299221E3("stat_31457B01625BA88C", ::_id_D73D513BFDCEB0DE);
  _id_308F735A299221E3("stat_A82D3B811A3FB27F", ::_id_E4B7CD2D98771113);
  _id_308F735A299221E3("stat_6E79A2415DF0BB8F", ::_id_0E8B059D58F07663);
  _id_308F735A299221E3("stat_5F60DE8E97522F86", ::_id_F3274ABE8BBCAC04);
  _id_308F735A299221E3("stat_73C962B7031CBD0B", ::_id_F98648E1DC6E63CF);
  _id_308F735A299221E3("stat_AEFD11FBDD846243", ::_id_52506C3CFDE54AA7);
  _id_308F735A299221E3("stat_DC67FFF967F34603", ::_id_38F459F70EA411A7);
  _id_308F735A299221E3("stat_DC67FEF967F34450", ::_id_2D04B4AD2BC66462);
  _id_308F735A299221E3("stat_2BD23A1809BB3649", ::_id_FD4087DE9DB4CDF1);
  _id_308F735A299221E3("stat_EF3157F31C9A957F", ::_id_A02B4E369B2CBCB3);
  _id_308F735A299221E3("stat_259BBBEF3259DF98", ::_id_3E92A8E47DBF91AA);
  _id_308F735A299221E3("stat_08BE4207B5627B6A", ::_id_BDCFC88E185572C8);
  _id_308F735A299221E3("stat_F5ECF1190CECD24A", ::_id_01EBE98051052C08);
  _id_308F735A299221E3("stat_681D1A8FC05751CB", ::_id_362790D530CB554F);
  _id_308F735A299221E3("stat_9130ED9EC3CE4F98", ::_id_FF45D70EF7FD700A);
  _id_308F735A299221E3("stat_08991A44E3E8F293", ::_id_A93D4E4D31895D77);
  _id_308F735A299221E3("stat_338F01A53D66642E", ::_id_836E832EF348CB0C);
  _id_308F735A299221E3("stat_1E8D785AE6DF0A28", ::_id_F6820874F2F4B7FA);
  _id_308F735A299221E3("stat_59196AF92BC6AA3D", ::_id_487AD6A4DE40BCF5);
  _id_308F735A299221E3("stat_82DB0BB8FD50F941", ::_id_AE90D417FBDBA2A9);
  _id_308F735A299221E3("stat_2EBDF941392E35C5", ::_id_98C6559ADE501E3D);
  _id_308F735A299221E3("stat_2B95DC192BCC3840", ::_id_E6385720C367C132);
  _id_308F735A299221E3("stat_2011DA7D0D5F5CD8", ::_id_BD496CB5C609EBEF);
  _id_308F735A299221E3("stat_732003CC9B00C0F7", ::_id_CDAD06C807F2982B);
  _id_308F735A299221E3("stat_406E05CC7EA70F01", ::_id_C05B05634B8BF729);
  _id_308F735A299221E3("stat_F88B15AC1E825338", ::_id_8E8A14AE1D93C4EA);
  _id_308F735A299221E3("stat_1F205DA2CE683602", ::_id_54ED38D3B5AC6140);
  _id_308F735A299221E3("stat_68B053938038F100", ::_id_5BA1ECAF98DCCFF2);
  _id_308F735A299221E3("stat_CE6DBBCBB4E41FBF", ::_id_24B135168CC16DF3);
  _id_308F735A299221E3("stat_C9B660E44932C74B", ::_id_487AD6A4DE40BCF5);
  _id_308F735A299221E3("stat_5E63AF4C407A7372", ::_id_37D7885E81477F70);
  _id_308F735A299221E3("stat_874FD366F12996A6", ::_id_3767C0581218EF04);
  _id_308F735A299221E3("stat_4BBAEF4331853C99", ::_id_088E7906B3427CA1);
  _id_308F735A299221E3("stat_F24671A6D4A055B8", ::_id_7EA50D23AE130CCA);
  _id_308F735A299221E3("stat_AD79ADD79761BB61", ::_id_5E562C7C6CD5FBE9);
  _id_308F735A299221E3("stat_4C47A2927E05D1ED", ::_id_362790D530CB554F);
  _id_308F735A299221E3("stat_05791A21B9207947", ::_id_AE90D417FBDBA2A9);
  _id_308F735A299221E3("stat_F1FC816BB5270A9C", ::_id_E6385720C367C132);
  _id_308F735A299221E3("stat_3D781F41E6ACC784", ::_id_BD496CB5C609EBEF);
  _id_308F735A299221E3("stat_B49F8E352F111D2D", ::_id_362790D530CB554F);
  _id_308F735A299221E3("stat_73646DC8663362F4", ::_id_E6385720C367C132);
  _id_503E263494654DF9("ufoSm", ::_id_E4F3EB6B0541DB27, ::_id_487AD6A4DE40BCF5);
  _id_503E263494654DF9("ufoLg", ::_id_2D38ADC3714F681E, ::_id_487AD6A4DE40BCF5);
  _id_503E263494654DF9("hlander", ::_id_66BD08D233ABC229, ::_id_487AD6A4DE40BCF5);
  _id_CDB30168AA4BA6D3("lilithEx", ::_id_987DADED215DF4DA, ::_id_5B42E2FEAB7A3AAE);
  _id_BD000D3682D66959("electricAnimeEquip", ::_id_1B44231F13746622, ::_id_F3274ABE8BBCAC04);
  _id_A180A5874C8CBE0B("flameSkullCharm", ::_id_2627A7EAEB3541E5, ::_id_D0003CB59BA90631);
  _id_A180A5874C8CBE0B("crystamSkullCharm", ::_id_1D7A9B121434DF64, ::_id_9DBA84E77BA81E68);
  _id_A180A5874C8CBE0B("starlightCharm", ::_id_0763547F85193043, ::_id_9E037532D806BFAF);
  _id_A180A5874C8CBE0B("soulEaterCharm", ::_id_244DE2BE6DD725F3, ::_id_7AC629D7829DA1DF);
  _id_A180A5874C8CBE0B("crowFootCharm", ::_id_0F8FC0821696182C, ::_id_163FCCF48F86AC68);
  _id_A180A5874C8CBE0B("pumpkinLanternCharm", ::_id_1C12797023D624E5, ::_id_3E50A64BBD61B969);
  _id_A180A5874C8CBE0B("weedCreatureCharm", ::_id_CE28357936D127F1, ::_id_67B827411821D1B1);
  _id_A180A5874C8CBE0B("doomChainsaw", ::_id_55D5C766B382551E, ::_id_7F84CAC49AC044C0);
  _id_52E87AA6385E7140("ghostFinder", ::_id_B397FC136A6C84EA, ::_id_DBACDDFFCF9EE00A);
  _id_F585A90BAEF927BB("reactive_kill_streak_2stage", ::_id_7E8329133EA16786);
  _id_F585A90BAEF927BB("reactive_match_kills_2stage", ::_id_882B5EA6E5345B31);
  _id_F585A90BAEF927BB("reactive_soul_collect_1stage", ::_id_D05F99B2455BAA0A);
  _id_F585A90BAEF927BB("reactive_movement", ::_id_40C8094DDA4E218F);
  _id_F585A90BAEF927BB("reactive_enchantment", ::_id_07EC064F982949E9);
  _id_F585A90BAEF927BB("reactive_downgradable_kill_streak_3stage", ::_id_777EED4426971F45);
  _id_F585A90BAEF927BB("reactive_kill_weapon_3stage", ::_id_3537CBD88E7EC6A8);
  _id_144B37D5935EE55E("reactive_kill");
  _id_144B37D5935EE55E("reactive_soul_collect");
  _id_0A92B5D21A4B45B0();
  _id_088B034261873044();
  _id_7342D9B11A2C7E61::_id_56BDD015D9DECAF5();

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("aggregator", "registerOnPlayerSpawnCallback"))
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("aggregator", "registerOnPlayerSpawnCallback")]](::_id_C72573FB42D0CDBC);
}

_id_503E263494654DF9(_id_2521725CD8132F65, _id_8931E7AF4448E384, _id_7B85D041FE0490B6) {
  _id_669C255552C5A202 = spawnStruct();
  _id_669C255552C5A202._id_E21935F6C2060F63 = _id_8931E7AF4448E384;
  _id_669C255552C5A202._id_79A24EC7FDD6E100 = _id_7B85D041FE0490B6;
  level._id_FB690B0442393F26[_id_2521725CD8132F65] = _id_669C255552C5A202;
}

_id_308F735A299221E3(_id_C3730D8BAE621A97, _id_7B85D041FE0490B6) {
  _id_669C255552C5A202 = spawnStruct();
  _id_669C255552C5A202._id_79A24EC7FDD6E100 = _id_7B85D041FE0490B6;
  level._id_F075B3A145F1C730[_id_C3730D8BAE621A97] = _id_669C255552C5A202;
}

_id_CA61BB01D1162121(_id_2521725CD8132F65, _id_8931E7AF4448E384, _id_7B85D041FE0490B6) {
  _id_669C255552C5A202 = spawnStruct();
  _id_669C255552C5A202._id_E21935F6C2060F63 = _id_8931E7AF4448E384;
  _id_669C255552C5A202._id_79A24EC7FDD6E100 = _id_7B85D041FE0490B6;
  level._id_7546F688873B4CE4[_id_2521725CD8132F65] = _id_669C255552C5A202;
}

_id_CDB30168AA4BA6D3(_id_2521725CD8132F65, _id_8931E7AF4448E384, _id_7B85D041FE0490B6) {
  _id_669C255552C5A202 = spawnStruct();
  _id_669C255552C5A202._id_E21935F6C2060F63 = _id_8931E7AF4448E384;
  _id_669C255552C5A202._id_79A24EC7FDD6E100 = _id_7B85D041FE0490B6;
  level._id_15F270E2898482BE[_id_2521725CD8132F65] = _id_669C255552C5A202;
}

_id_BD000D3682D66959(_id_2521725CD8132F65, _id_8931E7AF4448E384, _id_7B85D041FE0490B6) {
  _id_669C255552C5A202 = spawnStruct();
  _id_669C255552C5A202._id_E21935F6C2060F63 = _id_8931E7AF4448E384;
  _id_669C255552C5A202._id_79A24EC7FDD6E100 = _id_7B85D041FE0490B6;
  level._id_D83CA3F3BDF5B3D4[_id_2521725CD8132F65] = _id_669C255552C5A202;
}

_id_A180A5874C8CBE0B(_id_2521725CD8132F65, _id_76DB26F25E7DBAC7, _id_BA46EC67C5CAF4A2) {
  _id_7BDC9702E6500422 = spawnStruct();
  _id_7BDC9702E6500422._id_D7D02ABBC34DD7D2 = _id_76DB26F25E7DBAC7;
  _id_7BDC9702E6500422._id_BA46EC67C5CAF4A2 = _id_BA46EC67C5CAF4A2;
  level._id_A3D1147A42B2FD91[_id_2521725CD8132F65] = _id_7BDC9702E6500422;
}

_id_52E87AA6385E7140(_id_2521725CD8132F65, _id_2D2ED04D5A0051D2, _id_BA46EC67C5CAF4A2) {
  _id_7BDC9702E6500422 = spawnStruct();
  _id_7BDC9702E6500422._id_BCF25CEC488D34E3 = _id_2D2ED04D5A0051D2;
  _id_7BDC9702E6500422._id_BA46EC67C5CAF4A2 = _id_BA46EC67C5CAF4A2;
  level._id_88C1332FB32E977C[_id_2521725CD8132F65] = _id_7BDC9702E6500422;
}

_id_F585A90BAEF927BB(_id_2521725CD8132F65, _id_BA46EC67C5CAF4A2) {
  _id_7BDC9702E6500422 = spawnStruct();
  _id_7BDC9702E6500422._id_BA46EC67C5CAF4A2 = _id_BA46EC67C5CAF4A2;
  level._id_E65F4101FD50A0E1[_id_2521725CD8132F65] = _id_7BDC9702E6500422;
}

_id_144B37D5935EE55E(_id_2521725CD8132F65, _id_BA46EC67C5CAF4A2) {
  _id_7BDC9702E6500422 = spawnStruct();
  level._id_1C6C766B95B77E8A[_id_2521725CD8132F65] = _id_7BDC9702E6500422;
}

_id_0A92B5D21A4B45B0() {
  level._id_40E77024DC6BAE59 = [];

  if(!isDefined(level.mapname))
    level.mapname = getDvar("g_mapname");

  if(issubstr(level.mapname, "frontend")) {
    level._id_40E77024DC6BAE59["match_kill_thresholds_2stage"] = [2, 4];
    level._id_40E77024DC6BAE59["kill_streak_thresholds_2stage"] = [2, 4];
    level._id_40E77024DC6BAE59["kill_streak_thresholds_souleater"] = 1;
    level._id_40E77024DC6BAE59["downgradable_kill_streak_thresholds_3stage"] = _id_D4E38AD2AE67FD38();
  } else {
    level._id_40E77024DC6BAE59["match_kill_thresholds_2stage"] = _id_B7C399CD6018F474();
    level._id_40E77024DC6BAE59["kill_streak_thresholds_2stage"] = _id_15B4833097CAF079();
    level._id_40E77024DC6BAE59["kill_streak_thresholds_souleater"] = _id_68B32B8D783A8CA2();
    level._id_40E77024DC6BAE59["downgradable_kill_streak_thresholds_3stage"] = _id_D4E38AD2AE67FD38();
  }

  level._id_40E77024DC6BAE59["s6_distance_subscribers"] = [];
}

_id_C72573FB42D0CDBC() {
  _id_48ACDA7F56F30AAB();
  _id_DCC407F619256C57();
}

_id_48ACDA7F56F30AAB() {
  if(!_id_2947BE89DDF09115()) {
    _id_035C927994920A75("match_kills", 0);
    _id_035C927994920A75("kill_streak", 0);
    _id_035C927994920A75("downgradable_kill_streak", 0);
    _id_035C927994920A75("reactive_kills", 0);
    _id_035C927994920A75("souls_collected_count", 0);
    _id_035C927994920A75("ghost_radar_active", 0);
    _id_035C927994920A75("ghost_finder_sucking", 0);
    _id_035C927994920A75("kill_streak_weapon", []);
    _id_035C927994920A75("movement_state", "neutral");
    _id_035C927994920A75("all_scriptable_disablers", []);
    _id_035C927994920A75("direct_scriptable_disablers", []);
    _id_035C927994920A75("enchanted_weapons", []);
    _id_035C927994920A75("soul_ents_in_flight", []);
    _id_035C927994920A75("last_reactive_kill_time", -99999);
    _id_035C927994920A75("last_reticle_kill_time", -99999);
    _id_5B5E6DE151E0FECD("neutral");
    _id_6B2D1CC6BC7C8A90("neutral");

    foreach(_id_4041CDA36A5951FF, _id_7BDC9702E6500422 in level._id_E65F4101FD50A0E1)
    _id_4F0C5ACD6343C0DD(_id_4041CDA36A5951FF, "neutral");

    foreach(_id_4041CDA36A5951FF, _id_7BDC9702E6500422 in level._id_1C6C766B95B77E8A)
    _id_68444E56728A13A6(_id_4041CDA36A5951FF);
  }

  if(isPlayer(self)) {
    thread _id_BDA6A04EFD965C2F();
    thread _id_B11087D46D884B84();
  }
}

_id_2947BE89DDF09115() {
  return isDefined(self._id_E7A9752E4F4C7D97);
}

_id_B7C399CD6018F474() {
  if(isDefined(level._id_249CDFC0F19C1B42) && level._id_249CDFC0F19C1B42 > 0) {
    if(isDefined(level._id_249CDEC0F19C190F) && level._id_249CDEC0F19C190F > 0)
      return [level._id_249CDFC0F19C1B42, level._id_249CDEC0F19C190F];
  }

  return [10, 20];
}

_id_15B4833097CAF079() {
  return [2, 5];
}

_id_68B32B8D783A8CA2() {
  return 3;
}

_id_D4E38AD2AE67FD38() {
  return [2, 5, 8];
}

_id_B939BC4F3A6D4FDC(weapon) {
  _id_18A70F534CC2BC07();
  _id_A71517A0B579ED46(weapon);
  _id_CD88D52E8776B964(weapon);
  _id_045F7158271BBF93();
  _id_962FD936FB4491FA();
  _id_B66FA33D64BA4010("reactive_kill_weapon_3stage");
  _id_E6C5C00872A14E28();
  thread _id_0FF3FB5A24CFEE6D();
}

_id_0FF3FB5A24CFEE6D() {
  self endon("death_or_disconnect");
  self endon("weapon_change");
  waitframe();
  _id_79E98E41624BE7FC();
  _id_3B6459451C628249();
}

_id_7C62C6C14ABA289B() {
  _id_48ACDA7F56F30AAB();
  _id_E6C5C00872A14E28();
  _id_6631789B2A3ABE3C();
}

_id_ECEB462B367E4B04(_id_642470E1ABC1BBF9) {
  if(isDefined(_id_642470E1ABC1BBF9.attacker) && isPlayer(_id_642470E1ABC1BBF9.attacker))
    _id_642470E1ABC1BBF9.attacker _id_5C55CA428DD7B66B(self, _id_642470E1ABC1BBF9.objweapon, _id_642470E1ABC1BBF9.meansofdeath);

  _id_AF1ADC73DFFAFD19(_id_642470E1ABC1BBF9.objweapon, _id_642470E1ABC1BBF9.meansofdeath);
}

_id_1DD3A521EA9ECF27(attacker, objweapon, meansofdeath, hitloc, inflictor, executionref) {
  return _id_A952714A4C2F5C6F(attacker, objweapon, meansofdeath, hitloc, inflictor, executionref);
}

_id_BBEE2E46AB15A720(attacker, objweapon, meansofdeath, hitloc, inflictor) {
  if(isDefined(attacker) && isPlayer(attacker))
    attacker _id_5C55CA428DD7B66B(self, objweapon, meansofdeath);

  return _id_A952714A4C2F5C6F(attacker, objweapon, meansofdeath, hitloc, inflictor);
}

_id_D7C5900C7D5BB0DB(_id_642470E1ABC1BBF9) {
  if(isDefined(_id_642470E1ABC1BBF9.attacker) && isPlayer(_id_642470E1ABC1BBF9.attacker))
    _id_642470E1ABC1BBF9.attacker _id_5C55CA428DD7B66B(self, _id_642470E1ABC1BBF9.objweapon, _id_642470E1ABC1BBF9.meansofdeath);

  return _id_A952714A4C2F5C6F(_id_642470E1ABC1BBF9.attacker, _id_642470E1ABC1BBF9.objweapon, _id_642470E1ABC1BBF9.meansofdeath, _id_642470E1ABC1BBF9.hitloc);
}

_id_943511AB1F39DB66() {
  self endon("death_or_disconnect");
  self endon("shockStick_haywireApplied");
  _id_8F640A97343569F5("vfx_disabled_for_haywire");
  self waittill("haywire_cleared");
  wait 1;
  _id_35F7E3FE1D9653BC("vfx_disabled_for_haywire");
}

_id_606FA08E3AAC10D9() {
  _id_8F640A97343569F5("vfx_disabled_for_jugg");
}

_id_CB5051BFAB85D56A() {
  _id_35F7E3FE1D9653BC("vfx_disabled_for_jugg");
}

_id_112E56B7DBE18137() {
  _id_8F640A97343569F5("vfx_disabled_for_hiding");
}

_id_33637806FC5AC024() {
  _id_35F7E3FE1D9653BC("vfx_disabled_for_hiding");
}

_id_92D9B05BE48FE03E(entity) {
  return isDefined(entity) && isDefined(entity.model) && entity.model == "military_shooting_target_armor_01_assembly";
}

_id_8114951A631BD6A6() {
  return _id_D05F99B2455BAA0A();
}

_id_0150370C11A6C880(objweapon) {
  _id_513639AC267A9E7C = _id_C8F576B523885369(objweapon);

  if(isDefined(_id_513639AC267A9E7C))
    return _id_C8F576B523885369(objweapon) == "stat_B49F8E352F111D2D";

  return 0;
}

_id_4AE1058D4433F19D(eattacker) {
  if(getdvarint("dvar_CAEDD6EF69DC8A7A", 1)) {
    if(isDefined(eattacker) && isPlayer(eattacker) && isDefined(eattacker.currentweapon)) {
      if(_id_E514ED60E2C9F9FC(eattacker.currentweapon))
        return 1;
    }
  }

  return 0;
}

_id_E514ED60E2C9F9FC(weapon) {
  if(!isDefined(weapon))
    return 0;

  return _id_B397FC136A6C84EA(weapon);
}

_id_D8804135C49FD481(objweapon) {
  _id_513639AC267A9E7C = _id_C8F576B523885369(objweapon);

  if(isDefined(_id_513639AC267A9E7C))
    return _id_C8F576B523885369(objweapon) == "stat_C9B660E44932C74B";

  return 0;
}

_id_B5F3DE7931212CF5(idamage, victim) {
  if(getdvarint("dvar_F8094D20D531B0B5", 1)) {
    if(isDefined(victim)) {
      if(istrue(victim.zombie))
        idamage = idamage * getdvarint("dvar_5C741BD119D504FE", 1);
      else if(istrue(self._id_4924D9899B8D3124))
        idamage = idamage * getdvarint("dvar_5B0DE654FA5013BA", 1);
      else if(isDefined(victim.targetname) && victim.targetname == "veh9_ufo_lg")
        idamage = idamage * getdvarint("dvar_335D3B6AA7C7AC96", 1);
      else if(isDefined(victim.targetname) && victim.targetname == "saba_orb")
        idamage = idamage * getdvarint("dvar_BBF4AC6F9293A467", 1);
      else if(isDefined(victim.agent_type) && victim.agent_type == "actor_enemy_mp_boss_mummy_minion")
        idamage = idamage * getdvarint("dvar_74B01CCCD2B6AAF6", 1);
      else if(isDefined(victim.agent_type) && (victim.agent_type == "actor_enemy_mp_ar_tier3_affected_ru" || victim.agent_type == "actor_enemy_mp_jugg_affected_ru"))
        idamage = idamage * getdvarint("dvar_4D810BFF1F4993C4", 1);
      else if(isDefined(victim.agent_type) && victim.agent_type == "actor_enemy_mp_boss_swampmonster")
        idamage = idamage * getdvarint("dvar_6267EA49AA81A4D2", 1);
      else if(isDefined(victim.agent_type) && victim.agent_type == "actor_enemy_mp_boss_butcher")
        idamage = idamage * getdvarint("dvar_B85E4B9BC8F55A8D", 1);
      else if(isDefined(victim.agent_type) && victim.agent_type == "actor_enemy_mp_boss_mummy")
        idamage = idamage * getdvarint("dvar_ECFFB3B94BCD65BD", 1);
    }

    return idamage;
  }

  return idamage;
}

_id_6CEBD056176C1511() {
  _id_A2FF3959A0B6827E("reactive_soul_collect");
}

_id_4BED606F84DC5DEF() {
  if(self._id_E7A9752E4F4C7D97["ghost_radar_active"] && !self._id_E7A9752E4F4C7D97["ghost_finder_sucking"]) {
    self setscriptablepartstate("mtxVfxGunscreen", "ghostFinderActiveImmediate");
    self._id_E7A9752E4F4C7D97["ghost_finder_sucking"] = 1;
  }
}

_id_89F97780FE2DB098() {
  if(self._id_E7A9752E4F4C7D97["ghost_finder_sucking"]) {
    self setscriptablepartstate("mtxVfxGunscreen", "neutral");
    self._id_E7A9752E4F4C7D97["ghost_finder_sucking"] = 0;
  }
}

_id_AB1746BEF02556AB() {
  if(self._id_E7A9752E4F4C7D97["ghost_radar_active"])
    self setscriptablepartstate("mtxVfxGunscreenOneshot", "ghostFinderAbsorbed");
}

_id_A952714A4C2F5C6F(attacker, objweapon, meansofdeath, hitloc, inflictor, executionref) {
  if(meansofdeath == "MOD_SUICIDE")
    return 0;

  _id_F702BFC18BFFF040 = _id_C8F576B523885369(objweapon);

  if(isDefined(_id_F702BFC18BFFF040)) {}

  if(_id_29C197BA188D4225(meansofdeath) || _id_697903DB146DB3C2(meansofdeath)) {
    if(isDefined(_id_F702BFC18BFFF040))
      _id_EE221E87FD141D36 = _id_EA0DDC7EDE7C87B7(level._id_F075B3A145F1C730, attacker, _id_F702BFC18BFFF040, hitloc);
    else
      _id_EE221E87FD141D36 = _id_36D11B76451CDDE1(level._id_FB690B0442393F26, attacker, objweapon, hitloc);

    if(!_id_EE221E87FD141D36 && _id_2C3C990BA58FA6F5::_id_D3915632A8C61EB2())
      _id_1B411DFEDDEC6105(self.body, hitloc);

    return _id_EE221E87FD141D36;
  } else if(_id_07F864BC4CCAEE0B(meansofdeath)) {
    if(isDefined(_id_F702BFC18BFFF040))
      return _id_EA0DDC7EDE7C87B7(level._id_F075B3A145F1C730, attacker, _id_F702BFC18BFFF040, hitloc);
    else
      return _id_36D11B76451CDDE1(level._id_7546F688873B4CE4, attacker, objweapon, hitloc);
  } else if(_id_CF84BBECBF2CB341(meansofdeath) && isDefined(executionref)) {
    objweapon = spawnStruct();
    objweapon.executionref = executionref;
    return _id_36D11B76451CDDE1(level._id_15F270E2898482BE, attacker, objweapon, hitloc);
  } else if(_id_71D69964E12BDE1F(meansofdeath)) {
    if(_id_8542D26E5AC6C50C(inflictor))
      return _id_CE7272ACB57AAC2A(self.body);

    if(isDefined(_id_F702BFC18BFFF040))
      return _id_EA0DDC7EDE7C87B7(level._id_F075B3A145F1C730, attacker, _id_F702BFC18BFFF040, hitloc);
    else
      return _id_36D11B76451CDDE1(level._id_D83CA3F3BDF5B3D4, attacker, objweapon, hitloc);
  }

  return 0;
}

_id_07F864BC4CCAEE0B(meansofdeath) {
  return meansofdeath == "MOD_MELEE";
}

_id_CF84BBECBF2CB341(meansofdeath) {
  return meansofdeath == "MOD_EXECUTION";
}

_id_29C197BA188D4225(meansofdeath) {
  return meansofdeath == "MOD_RIFLE_BULLET" || meansofdeath == "MOD_EXPLOSIVE_BULLET" || meansofdeath == "MOD_HEAD_SHOT";
}

_id_71D69964E12BDE1F(meansofdeath) {
  return meansofdeath == "MOD_IMPACT" || meansofdeath == "MOD_GRENADE_SPLASH";
}

_id_697903DB146DB3C2(meansofdeath) {
  return meansofdeath == "MOD_CRUSH";
}

_id_36D11B76451CDDE1(_id_4F9E2CC6F3C3696A, attacker, objweapon, hitloc) {
  foreach(_id_918FB33C2FC82006, _id_78D10F1CFFCB27F6 in _id_4F9E2CC6F3C3696A) {
    if([[_id_78D10F1CFFCB27F6._id_E21935F6C2060F63]](objweapon)) {
      _id_EC2C8B1926C5865E = self[[_id_78D10F1CFFCB27F6._id_79A24EC7FDD6E100]](self.body, attacker, hitloc);
      return _id_EC2C8B1926C5865E;
    }
  }

  return 0;
}

_id_EA0DDC7EDE7C87B7(_id_3872DE29B941832D, attacker, _id_F702BFC18BFFF040, hitloc) {
  _id_EC2C8B1926C5865E = self[[_id_3872DE29B941832D[_id_F702BFC18BFFF040]._id_79A24EC7FDD6E100]](self.body, attacker, hitloc);
  return _id_EC2C8B1926C5865E;
}

_id_C8F576B523885369(objweapon) {
  if(isDefined(objweapon._id_AE6A0AD91417B5EF) && isDefined(objweapon._id_AE6A0AD91417B5EF._id_513639AC267A9E7C) && objweapon._id_AE6A0AD91417B5EF._id_513639AC267A9E7C != "")
    return objweapon._id_AE6A0AD91417B5EF._id_513639AC267A9E7C;

  if(isDefined(objweapon._id_9C12F2E2022A8FC7) && isDefined(objweapon._id_9C12F2E2022A8FC7._id_513639AC267A9E7C) && objweapon._id_9C12F2E2022A8FC7._id_513639AC267A9E7C != "")
    return objweapon._id_9C12F2E2022A8FC7._id_513639AC267A9E7C;

  return undefined;
}

_id_5C55CA428DD7B66B(victim, weapon, meansofdeath) {
  if(!_id_C34B61648A7556CF(victim, meansofdeath)) {
    return;
  }
  self._id_E7A9752E4F4C7D97["match_kills"]++;
  self._id_E7A9752E4F4C7D97["kill_streak"]++;
  self._id_E7A9752E4F4C7D97["downgradable_kill_streak"]++;
  _id_09297F6DCD8B3E0D(weapon);
  _id_B66FA33D64BA4010("reactive_kill_streak_2stage");
  _id_B66FA33D64BA4010("reactive_kill_weapon_3stage");
  _id_B66FA33D64BA4010("reactive_match_kills_2stage");
  _id_B66FA33D64BA4010("reactive_downgradable_kill_streak_3stage");
  thread _id_B4EBF862900A4D38();

  if(isDefined(weapon)) {
    _id_3029A9976599486C = _id_1B1244617E1E02E9(weapon, meansofdeath);

    if(istrue(_id_3029A9976599486C))
      thread _id_BB48EA90EF425E51();

    if(_id_AB36993386930071(weapon))
      thread _id_1ADE8D50B72171D2();
  }
}

_id_AF1ADC73DFFAFD19(objweapon, meansofdeath) {
  _id_D4E4935B9938F870();
  _id_B66FA33D64BA4010("reactive_kill_streak_2stage");
  _id_B66FA33D64BA4010("reactive_kill_weapon_3stage");
  _id_B66FA33D64BA4010("reactive_downgradable_kill_streak_3stage");
  _id_045F7158271BBF93();
  _id_962FD936FB4491FA();
  _id_DB40EC5717136688();
}

_id_09297F6DCD8B3E0D(weapon) {
  _id_D1A2243221CB157B = _id_4AE6F551AC0A40E3(weapon);

  if(_id_D1A2243221CB157B == "none") {
    return;
  }
  if(!isDefined(self._id_E7A9752E4F4C7D97["kill_streak_weapon"][_id_D1A2243221CB157B])) {
    if(self._id_E7A9752E4F4C7D97["kill_streak_weapon"].size > 8)
      self._id_E7A9752E4F4C7D97["kill_streak_weapon"] = _id_B9AA30537AC8A046(self._id_E7A9752E4F4C7D97["kill_streak_weapon"]);

    self._id_E7A9752E4F4C7D97["kill_streak_weapon"][_id_D1A2243221CB157B] = 0;
  }

  self._id_E7A9752E4F4C7D97["kill_streak_weapon"][_id_D1A2243221CB157B]++;
}

getkillstreakweapon(weapon) {
  _id_D1A2243221CB157B = _id_4AE6F551AC0A40E3(weapon);

  if(_id_D1A2243221CB157B == "none")
    return 0;

  if(!isDefined(self._id_E7A9752E4F4C7D97["kill_streak_weapon"][_id_D1A2243221CB157B]))
    return 0;

  return self._id_E7A9752E4F4C7D97["kill_streak_weapon"][_id_D1A2243221CB157B];
}

_id_4AE6F551AC0A40E3(weapon) {
  if(!isDefined(weapon) || !isDefined(weapon.basename))
    return "none";

  if(isDefined(weapon.variantid))
    _id_D1A2243221CB157B = weapon.basename + weapon.variantid;
  else
    _id_D1A2243221CB157B = weapon.basename;

  return _id_D1A2243221CB157B;
}

_id_B9AA30537AC8A046(array) {
  _id_BFC65A378A6D8EFE = [];
  _id_1E3E84886138B2E1 = 0;
  _id_BC002676438672C9 = self getweaponslistprimaries();
  _id_C72294B150863B65 = [];

  foreach(weapon in _id_BC002676438672C9)
  _id_C72294B150863B65[_id_C72294B150863B65.size] = _id_4AE6F551AC0A40E3(weapon);

  _id_C72294B150863B65 = scripts\engine\utility::array_remove_duplicates(_id_C72294B150863B65);

  foreach(key, value in array) {
    if(_id_1E3E84886138B2E1 < 3) {
      if(!scripts\engine\utility::array_contains(_id_C72294B150863B65, key)) {
        _id_1E3E84886138B2E1++;
        continue;
      }
    }

    _id_BFC65A378A6D8EFE[key] = value;
  }

  return _id_BFC65A378A6D8EFE;
}

_id_C34B61648A7556CF(victim, meansofdeath) {
  if(!isDefined(meansofdeath) || 0)
    return 0;

  if(!isDefined(victim) || victim == self)
    return 0;

  return 1;
}

_id_BDA6A04EFD965C2F() {
  self notify("mtx_manageOffhands");
  self endon("mtx_manageOffhands");
  self endon("death_or_disconnect");

  for(;;) {
    self waittill("weapon_switch_started");

    if(self isthrowinggrenade()) {
      _id_4ACA6CEF166CB640("vfx_disabled_for_offhand");
      self waittill("offhand_end");
      _id_FA5517DE80899543("vfx_disabled_for_offhand");
    }
  }
}

_id_B11087D46D884B84() {
  self notify("mtx_manageMovementDisable");
  self endon("mtx_manageMovementDisable");
  self endon("death_or_disconnect");

  for(;;) {
    while(!self _meth_635E39FC16A64657() && !self isskydiving() && !self isparachuting())
      waitframe();

    _id_4ACA6CEF166CB640("vfx_disabled_for_movement");

    while(self _meth_635E39FC16A64657() || self isskydiving() || self isparachuting())
      waitframe();

    _id_FA5517DE80899543("vfx_disabled_for_movement");
  }
}

_id_4ACA6CEF166CB640(_id_80B6655A5AD2EA87) {
  if(!isDefined(self._id_E7A9752E4F4C7D97)) {
    return;
  }
  if(!scripts\engine\utility::array_contains(self._id_E7A9752E4F4C7D97["direct_scriptable_disablers"], _id_80B6655A5AD2EA87))
    self._id_E7A9752E4F4C7D97["direct_scriptable_disablers"] = scripts\engine\utility::array_add(self._id_E7A9752E4F4C7D97["direct_scriptable_disablers"], _id_80B6655A5AD2EA87);

  _id_045F7158271BBF93();
  _id_962FD936FB4491FA();
}

_id_FA5517DE80899543(_id_80B6655A5AD2EA87) {
  if(!isDefined(self._id_E7A9752E4F4C7D97)) {
    return;
  }
  if(scripts\engine\utility::array_contains(self._id_E7A9752E4F4C7D97["direct_scriptable_disablers"], _id_80B6655A5AD2EA87))
    self._id_E7A9752E4F4C7D97["direct_scriptable_disablers"] = scripts\engine\utility::array_remove(self._id_E7A9752E4F4C7D97["direct_scriptable_disablers"], _id_80B6655A5AD2EA87);

  _id_79E98E41624BE7FC();
  _id_3B6459451C628249();
}

_id_8F640A97343569F5(_id_80B6655A5AD2EA87) {
  if(!isDefined(self._id_E7A9752E4F4C7D97)) {
    return;
  }
  if(!scripts\engine\utility::array_contains(self._id_E7A9752E4F4C7D97["all_scriptable_disablers"], _id_80B6655A5AD2EA87))
    self._id_E7A9752E4F4C7D97["all_scriptable_disablers"] = scripts\engine\utility::array_add(self._id_E7A9752E4F4C7D97["all_scriptable_disablers"], _id_80B6655A5AD2EA87);

  _id_045F7158271BBF93();
  _id_962FD936FB4491FA();
  _id_139C51CCB8268123();
}

_id_35F7E3FE1D9653BC(_id_80B6655A5AD2EA87) {
  if(!isDefined(self._id_E7A9752E4F4C7D97)) {
    return;
  }
  if(scripts\engine\utility::array_contains(self._id_E7A9752E4F4C7D97["all_scriptable_disablers"], _id_80B6655A5AD2EA87))
    self._id_E7A9752E4F4C7D97["all_scriptable_disablers"] = scripts\engine\utility::array_remove(self._id_E7A9752E4F4C7D97["all_scriptable_disablers"], _id_80B6655A5AD2EA87);

  _id_79E98E41624BE7FC();
  _id_3B6459451C628249();
  _id_DCC407F619256C57();
}

_id_79E98E41624BE7FC() {
  _id_50AF9AEEFFB058ED = 0;

  if(isDefined(self.currentweapon) && _id_6505B038FB96BB28()) {
    foreach(_id_4041CDA36A5951FF, _id_7BDC9702E6500422 in level._id_A3D1147A42B2FD91) {
      if([[_id_7BDC9702E6500422._id_D7D02ABBC34DD7D2]](self.currentweapon)) {
        thread _id_DFC52C6F1AE59BAF(_id_4041CDA36A5951FF, _id_7BDC9702E6500422, self.currentweapon);
        _id_50AF9AEEFFB058ED = 1;
        break;
      }
    }
  }

  if(!_id_50AF9AEEFFB058ED)
    _id_045F7158271BBF93();
}

_id_DFC52C6F1AE59BAF(_id_4041CDA36A5951FF, _id_7BDC9702E6500422, weapon) {
  if(!isDefined(weapon)) {
    return;
  }
  state = [[_id_7BDC9702E6500422._id_BA46EC67C5CAF4A2]](weapon);

  if(self._id_E7A9752E4F4C7D97["mtx_scriptable_charm_state"] != state) {
    self._id_E7A9752E4F4C7D97["mtx_scriptable_charm_state"] = state;
    self setscriptablepartstate("mtxVfxCharm", state);
  }
}

_id_045F7158271BBF93() {
  if(self._id_E7A9752E4F4C7D97["mtx_scriptable_charm_state"] != "neutral") {
    self._id_E7A9752E4F4C7D97["mtx_scriptable_charm_state"] = "neutral";
    self setscriptablepartstate("mtxVfxCharm", "neutral");
  }
}

_id_6505B038FB96BB28() {
  if(self._id_E7A9752E4F4C7D97["direct_scriptable_disablers"].size > 0 || self._id_E7A9752E4F4C7D97["all_scriptable_disablers"].size > 0)
    return 0;

  return 1;
}

_id_3B6459451C628249() {
  _id_3AE6D038DE81445A = 0;

  if(isDefined(self.currentweapon) && _id_8C5D76D279B0A609()) {
    foreach(_id_4041CDA36A5951FF, _id_7BDC9702E6500422 in level._id_88C1332FB32E977C) {
      if([[_id_7BDC9702E6500422._id_BCF25CEC488D34E3]](self.currentweapon)) {
        thread _id_198343D05A7A5EE0(_id_4041CDA36A5951FF, _id_7BDC9702E6500422, self.currentweapon);
        _id_3AE6D038DE81445A = 1;
        break;
      }
    }
  }

  if(!_id_3AE6D038DE81445A)
    _id_962FD936FB4491FA();
}

_id_198343D05A7A5EE0(_id_4041CDA36A5951FF, _id_7BDC9702E6500422, weapon) {
  if(!isDefined(weapon)) {
    return;
  }
  state = [[_id_7BDC9702E6500422._id_BA46EC67C5CAF4A2]](weapon);

  if(self._id_E7A9752E4F4C7D97["mtx_scriptable_gunscreen_state"] != state) {
    self._id_E7A9752E4F4C7D97["mtx_scriptable_gunscreen_state"] = state;
    self setscriptablepartstate("mtxVfxGunscreen", state);
  }
}

_id_962FD936FB4491FA() {
  if(self._id_E7A9752E4F4C7D97["mtx_scriptable_gunscreen_state"] != "neutral") {
    self._id_E7A9752E4F4C7D97["mtx_scriptable_gunscreen_state"] = "neutral";
    self setscriptablepartstate("mtxVfxGunscreen", "neutral");
  }
}

_id_8C5D76D279B0A609() {
  if(self._id_E7A9752E4F4C7D97["direct_scriptable_disablers"].size > 0 || self._id_E7A9752E4F4C7D97["all_scriptable_disablers"].size > 0)
    return 0;

  return 1;
}

_id_DCC407F619256C57() {
  foreach(_id_4041CDA36A5951FF, _id_7BDC9702E6500422 in level._id_E65F4101FD50A0E1)
  _id_B66FA33D64BA4010(_id_4041CDA36A5951FF);
}

_id_B66FA33D64BA4010(_id_4041CDA36A5951FF) {
  if(_id_3CAE60827C9F8AB0()) {
    _id_7BDC9702E6500422 = level._id_E65F4101FD50A0E1[_id_4041CDA36A5951FF];

    if(_id_46219D0188EF7627(_id_4041CDA36A5951FF, _id_7BDC9702E6500422))
      _id_D5D7CBE514C9E39F(_id_4041CDA36A5951FF, _id_7BDC9702E6500422);
  }
}

_id_6631789B2A3ABE3C() {
  foreach(_id_4041CDA36A5951FF, _id_7BDC9702E6500422 in level._id_E65F4101FD50A0E1)
  _id_588861CC60E51291(_id_4041CDA36A5951FF);
}

_id_588861CC60E51291(_id_4041CDA36A5951FF) {
  _id_7BDC9702E6500422 = level._id_E65F4101FD50A0E1[_id_4041CDA36A5951FF];
  _id_D5D7CBE514C9E39F(_id_4041CDA36A5951FF, _id_7BDC9702E6500422);
}

_id_D5D7CBE514C9E39F(_id_4041CDA36A5951FF, _id_7BDC9702E6500422) {
  state = [[_id_7BDC9702E6500422._id_BA46EC67C5CAF4A2]]();
  self setscriptablepartstate(_id_4041CDA36A5951FF, state);
  self._id_E7A9752E4F4C7D97["mtx_SCRIPTABLE_REACTIVE_IDs"][_id_4041CDA36A5951FF] = state;
}

_id_139C51CCB8268123() {
  foreach(_id_4041CDA36A5951FF, scriptablestate in self._id_E7A9752E4F4C7D97["mtx_SCRIPTABLE_REACTIVE_IDs"]) {
    if(scriptablestate != "neutral") {
      self setscriptablepartstate(_id_4041CDA36A5951FF, "neutral");
      self._id_E7A9752E4F4C7D97["mtx_SCRIPTABLE_REACTIVE_IDs"][_id_4041CDA36A5951FF] = "neutral";
    }
  }
}

_id_3CAE60827C9F8AB0() {
  if(self._id_E7A9752E4F4C7D97["all_scriptable_disablers"].size > 0)
    return 0;

  return 1;
}

_id_46219D0188EF7627(_id_4041CDA36A5951FF, _id_7BDC9702E6500422) {
  state = [[_id_7BDC9702E6500422._id_BA46EC67C5CAF4A2]]();
  return state != self._id_E7A9752E4F4C7D97["mtx_SCRIPTABLE_REACTIVE_IDs"][_id_4041CDA36A5951FF];
}

_id_A2FF3959A0B6827E(_id_4041CDA36A5951FF) {
  if(_id_5BCAD624C23D5C6F()) {
    state = self._id_E7A9752E4F4C7D97["mtx_scriptable_toggle_ids"][_id_4041CDA36A5951FF];

    if(state == "toggle0")
      _id_9B1941CB7354665E = "toggle1";
    else
      _id_9B1941CB7354665E = "toggle0";

    self setscriptablepartstate(_id_4041CDA36A5951FF, _id_9B1941CB7354665E);
    self._id_E7A9752E4F4C7D97["mtx_scriptable_toggle_ids"][_id_4041CDA36A5951FF] = _id_9B1941CB7354665E;
  }
}

_id_5BCAD624C23D5C6F() {
  if(self._id_E7A9752E4F4C7D97["all_scriptable_disablers"].size > 0)
    return 0;

  return 1;
}

_id_BB839BB513295F10(weapon) {
  if(!isDefined(weapon))
    return 0;

  if(!isDefined(weapon.basename) || !isDefined(weapon.variantid))
    return 0;

  if(weapon.basename == "iw9_me_sword01_mp" && weapon.variantid == 2)
    return 1;

  return 0;
}

_id_2627A7EAEB3541E5(weapon) {
  return weapon hasattachment("cos_iw9_156");
}

_id_D0003CB59BA90631(weapon) {
  return "flameSkullActive";
}

_id_1D7A9B121434DF64(weapon) {
  return weapon hasattachment("cos_iw9_445");
}

_id_0763547F85193043(weapon) {
  return weapon hasattachment("cos_iw9_465");
}

_id_244DE2BE6DD725F3(weapon) {
  return weapon hasattachment("cos_iw9_446");
}

_id_0F8FC0821696182C(weapon) {
  return weapon hasattachment("cos_iw9_501");
}

_id_1C12797023D624E5(weapon) {
  return weapon hasattachment("cos_iw9_500");
}

_id_CE28357936D127F1(weapon) {
  return weapon hasattachment("cos_iw9_526");
}

_id_55D5C766B382551E(weapon) {
  if(isDefined(weapon) && isDefined(weapon.receiver)) {
    if(weapon.receiver == "rec_pickaxe" && weapon.receivervarindex == 2)
      return 1;
  }

  return 0;
}

_id_9DBA84E77BA81E68(weapon) {
  return "crystalSkullActive";
}

_id_9E037532D806BFAF(weapon) {
  return "starlightActive";
}

_id_7AC629D7829DA1DF(weapon) {
  return "soulEaterActive";
}

_id_163FCCF48F86AC68(weapon) {
  return "crowFootActive";
}

_id_3E50A64BBD61B969(weapon) {
  return "pumpkinLanternActive";
}

_id_67B827411821D1B1(weapon) {
  return "weedCreatureActive";
}

_id_7F84CAC49AC044C0(weapon) {
  return "doomChainsawActive";
}

_id_DBACDDFFCF9EE00A(weapon) {
  if(istrue(self._id_E7A9752E4F4C7D97["player_absorbing_ghost"]))
    return "ghostFinderActiveWeaponSwitch";

  return "neutral";
}

_id_882B5EA6E5345B31() {
  _id_B9A2CB5922F06620 = level._id_40E77024DC6BAE59["match_kill_thresholds_2stage"][0];
  _id_93CDD6FEF72F81F9 = level._id_40E77024DC6BAE59["match_kill_thresholds_2stage"][1];
  state = "neutral";

  if(self._id_E7A9752E4F4C7D97["match_kills"] >= _id_93CDD6FEF72F81F9)
    state = "stage2";
  else if(self._id_E7A9752E4F4C7D97["match_kills"] >= _id_B9A2CB5922F06620)
    state = "stage1";

  return state;
}

_id_7E8329133EA16786() {
  _id_B9A2CB5922F06620 = level._id_40E77024DC6BAE59["kill_streak_thresholds_2stage"][0];
  _id_93CDD6FEF72F81F9 = level._id_40E77024DC6BAE59["kill_streak_thresholds_2stage"][1];
  state = "neutral";

  if(self._id_E7A9752E4F4C7D97["kill_streak"] >= _id_93CDD6FEF72F81F9)
    state = "stage2";
  else if(self._id_E7A9752E4F4C7D97["kill_streak"] >= _id_B9A2CB5922F06620)
    state = "stage1";

  return state;
}

_id_3537CBD88E7EC6A8() {
  state = "neutral";
  _id_86ADF5FEA6287FFF = getkillstreakweapon(self.currentweapon);

  if(_id_86ADF5FEA6287FFF >= 3)
    state = "stage3";
  else if(_id_86ADF5FEA6287FFF >= 2)
    state = "stage2";
  else if(_id_86ADF5FEA6287FFF >= 1)
    state = "stage1";

  return state;
}

_id_D05F99B2455BAA0A() {
  _id_B9A2CB5922F06620 = level._id_40E77024DC6BAE59["kill_streak_thresholds_souleater"];
  state = "neutral";

  if(self._id_E7A9752E4F4C7D97["souls_collected_count"] >= _id_B9A2CB5922F06620)
    state = "stage1";

  return state;
}

_id_40C8094DDA4E218F() {
  return self._id_E7A9752E4F4C7D97["movement_state"];
}

_id_023E4C8521B45498(weapon) {
  if(isDefined(weapon))
    return weapon.basename;
  else
    return "NONE";
}

_id_07EC064F982949E9() {
  weaponname = _id_023E4C8521B45498(self.currentweapon);
  _id_5AD86A368D32210E = self._id_E7A9752E4F4C7D97["enchanted_weapons"][weaponname];

  if(isDefined(_id_5AD86A368D32210E) && _id_5AD86A368D32210E == 1)
    return "stage1";
  else
    return "neutral";
}

_id_777EED4426971F45() {
  return _id_AD8D1B9C1EA44000("stage1", "stage2", "stage3", "dvar_E001A97B368816C9");
}

_id_AD8D1B9C1EA44000(_id_B95170AA27B06F28, _id_B95173AA27B075C1, _id_B95172AA27B0738E, _id_9F9C381AE9DF11A9) {
  _id_B2572A23D002338B = level._id_40E77024DC6BAE59["downgradable_kill_streak_thresholds_3stage"][0];
  _id_5585482EF6D686A8 = level._id_40E77024DC6BAE59["downgradable_kill_streak_thresholds_3stage"][1];
  _id_183F7DA8B19D815D = level._id_40E77024DC6BAE59["downgradable_kill_streak_thresholds_3stage"][2];
  state = "neutral";

  if(self._id_E7A9752E4F4C7D97["downgradable_kill_streak"] >= _id_183F7DA8B19D815D)
    state = _id_B95172AA27B0738E;
  else if(self._id_E7A9752E4F4C7D97["downgradable_kill_streak"] >= _id_5585482EF6D686A8)
    state = _id_B95173AA27B075C1;
  else if(self._id_E7A9752E4F4C7D97["downgradable_kill_streak"] >= _id_B2572A23D002338B)
    state = _id_B95170AA27B06F28;

  thread _id_F472570673162B39();
  return state;
}

_id_F472570673162B39() {
  self notify("mtx_monitorReactiveKillstreak3StageDecay");
  self endon("death_or_disconnect");
  self endon("mtx_monitorReactiveKillstreak3StageDecay");
  decaytime = getdvarfloat("dvar_17BC5FDC392BA0B3", 8000) / 1000;

  for(;;) {
    wait(decaytime);
    self._id_E7A9752E4F4C7D97["downgradable_kill_streak"]--;

    if(self._id_E7A9752E4F4C7D97["downgradable_kill_streak"] < 0)
      self._id_E7A9752E4F4C7D97["downgradable_kill_streak"] = 0;

    thread _id_B66FA33D64BA4010("reactive_downgradable_kill_streak_3stage");
  }
}

_id_2CFB11425A235D64() {
  if(isDefined(self.operatorcustomization) && isDefined(self.operatorcustomization.skinref)) {
    if(self.operatorcustomization.skinref + "" == "370")
      return 1;
  }

  return 0;
}

_id_BF8AB58E8E7B5238(weapon) {
  if(isDefined(weapon) && weapon.basename == "iw9_sm_aviktor_mp")
    return isDefined(weapon.variantid) && weapon.variantid == 25;

  return 0;
}

_id_81837D4D838C9FE4() {
  if(_id_EE73CE9F8E9E7938(self.currentweapon))
    thread _id_0DD5E7E7D9DCDC45(self.currentweapon);
  else
    _id_30F8126CB8555725();
}

_id_EE73CE9F8E9E7938(weapon) {
  if(isDefined(weapon) && weapon.basename == "iw9_sn_india_mp")
    return isDefined(weapon.variantid) && weapon.variantid == 14;

  return 0;
}

_id_0DD5E7E7D9DCDC45(weapon) {
  self notify("inspect_update_thread");
  self endon("death_or_disconnect");
  self endon("inspect_update_thread");
  weaponname = weapon.basename;
  _id_B66FA33D64BA4010("reactive_enchantment");

  for(;;) {
    self waittill("weapon_inspect");
    _id_670FE78573AF87EB(weaponname);
    _id_B66FA33D64BA4010("reactive_enchantment");
  }
}

_id_1279657A7F30AE15(state) {
  if(!_id_EE73CE9F8E9E7938(self.currentweapon) || !isDefined(self._id_E7A9752E4F4C7D97["enchanted_weapons"])) {
    return;
  }
  if(state != 0 && state != 1) {}

  self._id_E7A9752E4F4C7D97["enchanted_weapons"][_id_023E4C8521B45498(self.currentweapon)] = state;
  _id_6D5278C2D03FA5DF();
}

_id_670FE78573AF87EB(weaponname) {
  currentstate = _id_07EC064F982949E9();

  if(currentstate == "neutral")
    _id_1279657A7F30AE15(1);
  else
    _id_1279657A7F30AE15(0);
}

_id_30F8126CB8555725() {
  self notify("inspect_update_thread");
}

_id_E6C5C00872A14E28() {
  if(_id_2CFB11425A235D64() || _id_BF8AB58E8E7B5238(self.currentweapon))
    thread _id_E6A59E9B581F1AF6();
  else
    _id_D9C8739EB93AB7D9();
}

_id_E6A59E9B581F1AF6() {
  self notify("movement_update_thread");
  self endon("death_or_disconnect");
  self endon("movement_update_thread");
  currentstate = self._id_E7A9752E4F4C7D97["movement_state"];
  _id_8224573F9AB4D7A8 = 0;

  for(;;) {
    movement = self getnormalizedmovement();
    movement = abs(movement[0]) + abs(movement[1]);

    if(movement > 0.7 && !self playerads() > 0 && self getstance() == "stand")
      _id_8224573F9AB4D7A8 = 1;
    else
      _id_8224573F9AB4D7A8 = 0;

    if(self issprinting() || !self isonground() || self _meth_E5BF22923D0004BC() || self issprintsliding() || _id_8224573F9AB4D7A8) {
      _id_9E50CEF01527FF79 = "neutral";
      _id_74B5B12BB6514385 = 0.0;
    } else {
      _id_9E50CEF01527FF79 = "stage1";
      _id_74B5B12BB6514385 = 0.0;
    }

    if(currentstate != _id_9E50CEF01527FF79) {
      childthread _id_7AE9C5DF682996EF(_id_9E50CEF01527FF79, _id_74B5B12BB6514385);
      currentstate = _id_9E50CEF01527FF79;
    }

    wait 0.1;
  }
}

_id_7AE9C5DF682996EF(state, _id_74B5B12BB6514385) {
  self notify("newMovementState");
  self endon("newMovementState");
  wait(_id_74B5B12BB6514385);
  self._id_E7A9752E4F4C7D97["movement_state"] = state;
  _id_B66FA33D64BA4010("reactive_movement");
}

_id_D9C8739EB93AB7D9() {
  self notify("movement_update_thread");
}

_id_B4EBF862900A4D38() {
  self notify("updating_reactive_kills");
  self endon("death_or_disconnect");
  self endon("updating_reactive_kills");

  for(;;) {
    time = gettime();
    _id_72D7FEA8136633DA = time - self._id_E7A9752E4F4C7D97["last_reactive_kill_time"];

    if(_id_72D7FEA8136633DA >= 600) {
      if(self._id_E7A9752E4F4C7D97["match_kills"] > self._id_E7A9752E4F4C7D97["reactive_kills"]) {
        _id_A2FF3959A0B6827E("reactive_kill");
        self._id_E7A9752E4F4C7D97["last_reactive_kill_time"] = time;
        self._id_E7A9752E4F4C7D97["reactive_kills"]++;
      } else
        return;

      waittime = 0.6;
    } else
      waittime = (600 - _id_72D7FEA8136633DA) / 1000;

    wait(waittime);
  }
}

_id_18A70F534CC2BC07() {
  if(_id_E514ED60E2C9F9FC(self.currentweapon) && !self._id_E7A9752E4F4C7D97["ghost_radar_active"]) {
    _id_7342D9B11A2C7E61::_id_7254A85E981BEE68();
    self._id_E7A9752E4F4C7D97["ghost_radar_active"] = 1;
  } else if(!_id_E514ED60E2C9F9FC(self.currentweapon) && self._id_E7A9752E4F4C7D97["ghost_radar_active"]) {
    _id_7342D9B11A2C7E61::_id_F39E6A792512552D();
    self._id_E7A9752E4F4C7D97["ghost_radar_active"] = 0;
  }
}

_id_CD88D52E8776B964(weapon) {
  if(_id_43821739CB53D078(weapon))
    thread _id_D565E18B86416A77(weapon);
  else
    _id_4866E2B578C128D7();
}

_id_D565E18B86416A77(weapon) {
  self notify("doom_gunscreen_thread");
  self endon("death_or_disconnect");
  self endon("doom_gunscreen_thread");
  self endon("weapon_change");

  if(!isDefined(self._id_E7A9752E4F4C7D97["gunscreen_doom_hide"]))
    self._id_E7A9752E4F4C7D97["gunscreen_doom_hide"] = 0;

  for(;;) {
    if(self issprinting() || self _meth_635E39FC16A64657() || self issprintsliding() || self _meth_E5BF22923D0004BC()) {
      if(!self._id_E7A9752E4F4C7D97["gunscreen_doom_hide"]) {
        self._id_E7A9752E4F4C7D97["gunscreen_doom_hide"] = 1;
        self setclientomnvar("ui_doomscreen_hide", 1);
      }
    } else if(self._id_E7A9752E4F4C7D97["gunscreen_doom_hide"]) {
      self._id_E7A9752E4F4C7D97["gunscreen_doom_hide"] = 0;
      self setclientomnvar("ui_doomscreen_hide", 0);
    }

    waitframe();
  }
}

_id_4866E2B578C128D7() {
  self notify("doom_gunscreen_thread");
  self._id_E7A9752E4F4C7D97["gunscreen_doom_hide"] = 0;
  self setclientomnvar("ui_doomscreen_hide", 0);
}

_id_B397FC136A6C84EA(objweapon) {
  if(objweapon hasattachment("cos_iw9_screen_029"))
    return 1;

  return 0;
}

_id_43821739CB53D078(objweapon) {
  if(objweapon hasattachment("cos_iw9_screen_028"))
    return 1;

  return 0;
}

_id_A71517A0B579ED46(weapon) {
  if(_id_B376B213145194D3(weapon))
    thread _id_E56763DBB208985C(weapon);
}

_id_AB36993386930071(weapon) {
  if(_id_A124F473C9B83542(weapon))
    return 1;

  if(_id_74EE609C2CECE3B0(weapon))
    return 1;

  if(_id_390C36EC2DEDDABE(weapon))
    return 1;

  if(_id_73C5C19FBD622826(weapon))
    return 1;

  if(_id_3DF504BC71EFD9E8(weapon))
    return 1;

  return 0;
}

_id_70D9FDE7AB8FE4F4(weapon) {
  return 0;
}

_id_1ADE8D50B72171D2() {
  self setclientomnvar("ui_reticle_mtx_action2", self._id_E7A9752E4F4C7D97["match_kills"]);
  self._id_E7A9752E4F4C7D97["last_reticle_kill_time"] = gettime();
}

_id_B92E7556D13A2D52() {
  self setclientomnvar("ui_reticle_mtx_action2", self._id_E7A9752E4F4C7D97["souls_collected_count"]);
}

_id_6D5278C2D03FA5DF() {
  self setclientomnvar("ui_reticle_mtx_inspect", self._id_E7A9752E4F4C7D97["enchanted_weapons"][_id_023E4C8521B45498(self.currentweapon)]);
}

_id_511D0CB4A6FE51D2() {
  self setclientomnvar("ui_reticle_mtx_focus", self._id_E7A9752E4F4C7D97["mtx_focus"]);
}

_id_3D36736882540029(weapon) {
  self notify("mtx_focus_thread");
  self endon("death_or_disconnect");
  self endon("mtx_focus_thread");
  self endon("weapon_change");
  _id_035C927994920A75("mtx_focus", 0);
  _id_CA9D759B56D9C420 = 0;

  for(;;) {
    if(isDefined(self.focus) && _id_CA9D759B56D9C420 != self.focus) {
      _id_CA9D759B56D9C420 = self.focus;
      self._id_E7A9752E4F4C7D97["mtx_focus"] = _id_CA9D759B56D9C420;
      _id_511D0CB4A6FE51D2();
    }

    waitframe();
  }
}

_id_BCDEEA59D1C8C709() {
  self notify("mtx_focus_thread");
}

_id_E56763DBB208985C(weapon) {
  _id_035C927994920A75("hearts_broken", 0);
  _id_035C927994920A75("hearts_broken_incrementing", 0);

  if(_id_00F2626CC5D4205F(weapon))
    self setclientomnvar("ui_reticle_mtx_action2", self._id_E7A9752E4F4C7D97["hearts_broken"]);
  else
    self setclientomnvar("ui_reticle_mtx_action2", -1);
}

_id_BB48EA90EF425E51() {
  self endon("death_or_disconnect");
  self._id_E7A9752E4F4C7D97["hearts_broken"]++;

  if(self._id_E7A9752E4F4C7D97["hearts_broken_incrementing"]) {
    return;
  }
  self._id_E7A9752E4F4C7D97["hearts_broken_incrementing"] = 1;
  wait 0.1;

  for(;;) {
    _id_3E955591D6FEBC8D = self getclientomnvar("ui_reticle_mtx_action2");

    if(_id_3E955591D6FEBC8D >= self._id_E7A9752E4F4C7D97["hearts_broken"]) {
      self._id_E7A9752E4F4C7D97["hearts_broken_incrementing"] = 0;
      return;
    }

    self setclientomnvar("ui_reticle_mtx_action2", _id_3E955591D6FEBC8D + 1);
    wait 0.57;
  }
}

_id_DB40EC5717136688() {
  if(isDefined(self._id_E7A9752E4F4C7D97) && isDefined(self._id_E7A9752E4F4C7D97["hearts_broken"])) {
    self._id_E7A9752E4F4C7D97["hearts_broken"] = 0;
    self._id_E7A9752E4F4C7D97["hearts_broken_incrementing"] = 0;
  }
}

_id_B376B213145194D3(weapon) {
  return isDefined(weapon.scope) && weapon.scope == "hybrid03" && weapon.scopevarindex == 4;
}

_id_A124F473C9B83542(weapon) {
  return isDefined(weapon.scope) && weapon.scope == "reflex02_tall" && weapon.scopevarindex == 27;
}

_id_74EE609C2CECE3B0(weapon) {
  if(isDefined(weapon.scope)) {
    if(gettime() - self._id_E7A9752E4F4C7D97["last_reticle_kill_time"] > 1770) {
      if(weapon.scope == "reflex07_tall" && weapon.scopevarindex == 18)
        return 1;

      if(weapon.scope == "fourx02" && weapon.scopevarindex == 11)
        return 1;
    }
  }

  return 0;
}

_id_390C36EC2DEDDABE(weapon) {
  return isDefined(weapon.scope) && weapon.scope == "reflex02_tall" && weapon.scopevarindex == 31;
}

_id_73C5C19FBD622826(weapon) {
  if(gettime() - self._id_E7A9752E4F4C7D97["last_reticle_kill_time"] > 1000)
    return isDefined(weapon.scope) && weapon.scope == "vzscope_mromeo" && weapon.scopevarindex == 2;
}

_id_3DF504BC71EFD9E8(weapon) {
  return isDefined(weapon.scope) && weapon.scope == "reflex02_tall" && weapon.scopevarindex == 44;
}

_id_78EDD771B80BB678(weapon) {
  return isDefined(weapon.scope) && weapon.scope == "bar_ar_longhvy_scope_p52" && weapon.scopevarindex == 1;
}

_id_69DDD69E3AA4E4C9(weapon) {
  return isDefined(weapon.scope) && weapon.scope == "fourx04" && weapon.scopevarindex == 13;
}

_id_EA45A0C788F3200C(weapon) {
  return 0;
}

_id_7FD832AD7580949A(weapon) {
  if(isDefined(weapon.scope)) {
    if(weapon.scope == "holotherm" && weapon.scopevarindex == 22)
      return 1;

    if(weapon.scope == "fourxtherm01" && weapon.scopevarindex == 2)
      return 1;
  }

  return 0;
}

_id_00F2626CC5D4205F(weapon) {
  return isDefined(weapon.modifier) && weapon.modifier == "ammo_9s" && weapon.modifiervarindex == 2;
}

_id_1B1244617E1E02E9(weapon, meansofdeath) {
  return _id_B376B213145194D3(weapon) && _id_00F2626CC5D4205F(weapon) && isDefined(meansofdeath) && meansofdeath != "MOD_MELEE";
}

_id_2D38ADC3714F681E(objweapon) {
  return isDefined(objweapon.basename) && objweapon.basename == "chopper_gunner_turret_ufo_lg_mp";
}

_id_E4F3EB6B0541DB27(objweapon) {
  return isDefined(objweapon.basename) && objweapon.basename == "chopper_gunner_turret_ufo_mp";
}

_id_66BD08D233ABC229(objweapon) {
  if(isDefined(objweapon.basename) && (objweapon.basename == "super_laser_charge_mp" || objweapon.basename == "high_jump_mp"))
    return 1;

  if(isDefined(objweapon.modifier)) {
    if(objweapon.modifier == "ammo_556n" && objweapon.modifiervarindex == 22)
      return 1;

    if(objweapon.modifier == "ammo_556n_p43" && objweapon.modifiervarindex == 24)
      return 1;

    if(objweapon.modifier == "ammo_5x28" && objweapon.modifiervarindex == 3)
      return 1;
  }

  return 0;
}

_id_987DADED215DF4DA(_id_292CD00B3E8F1BC4) {
  if(_id_292CD00B3E8F1BC4.executionref == "execution_061")
    return 1;

  return 0;
}

_id_1F371614807624C3(objweapon) {
  if(_id_D8804135C49FD481(objweapon))
    return 1;

  return 0;
}

_id_1B44231F13746622(objweapon) {
  if(isDefined(objweapon.basename)) {
    switch (objweapon.basename) {
      case "bunkerbuster_round_gl_v2_mp":
      case "bunkerbuster_not_burrowed_gl_v2_mp":
      case "bunkerbuster_burrowed_gl_v2_mp":
      case "bunkerbuster_gl_v2_mp":
        return 1;
      default:
    }
  }

  return 0;
}

_id_036F3C1F20204B13(_id_6E784C378272FCAA, attacker, hitloc) {
  _id_687BA52E53E097AC(_id_6E784C378272FCAA, "youveBeenNaughty_limb", "youveBeenNaughty_torso", "youveBeenNaughty_head");
  return 1;
}

_id_777C1F2E7F15D92E(_id_6E784C378272FCAA, attacker, hitloc) {
  _id_687BA52E53E097AC(_id_6E784C378272FCAA, "youveBeenNice_limb", "youveBeenNice_torso", "youveBeenNice_head");
  return 1;
}

_id_337B80F7FF25B0C9(_id_6E784C378272FCAA, attacker, hitloc) {
  _id_687BA52E53E097AC(_id_6E784C378272FCAA, "vDay_limb", "vDay_torso", "vDay_head");
  return 1;
}

_id_1A406EDD298ED8AD(_id_6E784C378272FCAA, attacker, hitloc) {
  if(isdismembermentenabled())
    _id_687BA52E53E097AC(_id_6E784C378272FCAA, "bCell_limb", "bCell_torso", "bCell_head");
  else
    _id_687BA52E53E097AC(_id_6E784C378272FCAA, "bCell_nogore_limb", "bCell_nogore_torso", "bCell_nogore_head");

  return 1;
}

_id_F7BCA22A37224D8B(_id_6E784C378272FCAA, attacker, hitloc) {
  _id_DFCEE2EBE02A6AE7(_id_6E784C378272FCAA, "purple_shock");
  return 0;
}

_id_583F9260E6221231(_id_6E784C378272FCAA, attacker, hitloc) {
  _id_687BA52E53E097AC(_id_6E784C378272FCAA, "paddy_limb", "paddy_torso", "paddy_head");
  return 1;
}

_id_1B5DFB950D2E6DD2(_id_6E784C378272FCAA, attacker, hitloc) {
  _id_DFCEE2EBE02A6AE7(_id_6E784C378272FCAA, "shredder");
  return 0;
}

_id_0436125459CF039E(_id_6E784C378272FCAA, attacker, hitloc) {
  _id_0988BD2FED09E41C("j_spineupper", "sbandit_fatal");
  _id_833113CEB5556A93(_id_6E784C378272FCAA);
  return 1;
}

_id_0103D412A4079B9A(_id_6E784C378272FCAA, attacker, hitloc) {
  _id_0988BD2FED09E41C("tag_sync", "spider_fatal");
  _id_833113CEB5556A93(_id_6E784C378272FCAA);
  return 1;
}

_id_731555C8BF961FAE(_id_6E784C378272FCAA, attacker, hitloc) {
  _id_0988BD2FED09E41C("tag_sync", "arcstorm_fatal");
  return 1;
}

_id_3767C0581218EF04(_id_6E784C378272FCAA, attacker, hitloc) {
  _id_0988BD2FED09E41C("tag_sync", "spaceignition_fatal");
  return 0;
}

_id_4A614A5BCB3B50CB(_id_6E784C378272FCAA, attacker, hitloc) {
  _id_0988BD2FED09E41C("tag_sync", "slatedprism_fatal");
  _id_833113CEB5556A93(_id_6E784C378272FCAA);
  return 1;
}

_id_D73D513BFDCEB0DE(_id_6E784C378272FCAA, attacker, hitloc) {
  _id_0988BD2FED09E41C("tag_sync", "cyberviking_fatal");
  return 0;
}

_id_E4B7CD2D98771113(_id_6E784C378272FCAA, attacker, hitloc) {
  _id_0988BD2FED09E41C("tag_sync", "banshee_fatal");
  return 0;
}

_id_0E8B059D58F07663(_id_6E784C378272FCAA, attacker, hitloc) {
  _id_0988BD2FED09E41C("tag_sync", "crytempest_fatal");
  _id_833113CEB5556A93(_id_6E784C378272FCAA);
  return 1;
}

_id_F98648E1DC6E63CF(_id_6E784C378272FCAA, attacker, hitloc) {
  if(isdismembermentenabled())
    _id_687BA52E53E097AC(_id_6E784C378272FCAA, "easter_limb", "easter_torso", "easter_head");
  else
    _id_687BA52E53E097AC(_id_6E784C378272FCAA, "easter_nogore_limb", "easter_nogore_torso", "easter_nogore_head");

  return 1;
}

_id_F3274ABE8BBCAC04(_id_6E784C378272FCAA, attacker, hitloc) {
  _id_DFCEE2EBE02A6AE7(_id_6E784C378272FCAA, "electricAnime");
  return 0;
}

_id_52506C3CFDE54AA7(_id_6E784C378272FCAA, attacker, hitloc) {
  _id_687BA52E53E097AC(_id_6E784C378272FCAA, "scifi_limb", "scifi_torso", "scifi_head");
  _id_0988BD2FED09E41C("tag_origin", "scifi_origin");
  return 1;
}

_id_38F459F70EA411A7(_id_6E784C378272FCAA, attacker, hitloc) {
  _id_687BA52E53E097AC(_id_6E784C378272FCAA, "scifi2_limb", "scifi2_torso", "scifi2_head");
  _id_0988BD2FED09E41C("tag_origin", "scifi2_origin");
  return 1;
}

_id_2D04B4AD2BC66462(_id_6E784C378272FCAA, attacker, hitloc) {
  _id_687BA52E53E097AC(_id_6E784C378272FCAA, "scifi3_limb", "scifi3_torso", "scifi3_head");
  _id_0988BD2FED09E41C("tag_origin", "scifi3_origin");
  return 1;
}

_id_FD4087DE9DB4CDF1(_id_6E784C378272FCAA, attacker, hitloc) {
  _id_0988BD2FED09E41C("j_spineupper", "420_death");
  return 0;
}

_id_A02B4E369B2CBCB3(_id_6E784C378272FCAA, attacker, hitloc) {
  _id_0988BD2FED09E41C("j_spineupper", "hitscan");
  return 0;
}

_id_5BA1ECAF98DCCFF2(_id_6E784C378272FCAA, attacker, hitloc) {
  _id_0988BD2FED09E41C("j_spine4", "witch");
  _id_833113CEB5556A93(_id_6E784C378272FCAA);
  return 1;
}

_id_24B135168CC16DF3(_id_6E784C378272FCAA, attacker, hitloc) {
  if(hitloc == "head" || hitloc == "helmet") {
    _id_0988BD2FED09E41C("j_spine4", "zombie");
    _id_833113CEB5556A93(_id_6E784C378272FCAA);
    return 1;
  }

  return 0;
}

_id_3E92A8E47DBF91AA(_id_6E784C378272FCAA, attacker, hitloc) {
  _id_0988BD2FED09E41C("tag_origin", "thor");
  _id_0988BD2FED09E41C("j_spineupper", "thor_chest");
  _id_833113CEB5556A93(_id_6E784C378272FCAA);
  return 1;
}

_id_BDCFC88E185572C8(_id_6E784C378272FCAA, attacker, hitloc) {
  _id_DFCEE2EBE02A6AE7(_id_6E784C378272FCAA, "kd");
  return 0;
}

_id_01EBE98051052C08(_id_6E784C378272FCAA, attacker, hitloc) {
  _id_DFCEE2EBE02A6AE7(_id_6E784C378272FCAA, "cdl");
  return 0;
}

_id_362790D530CB554F(_id_6E784C378272FCAA, attacker, hitloc) {
  _id_71C779C0BCACE65A = 0;
  _id_687BA52E53E097AC(_id_6E784C378272FCAA, "soulEater_limb", "soulEater_torso", "soulEater_head", undefined, _id_71C779C0BCACE65A);
  _id_0988BD2FED09E41C("tag_origin", "soulEater_death");
  attacker thread _id_694E1B7805093C52(_id_6E784C378272FCAA);
  return _id_71C779C0BCACE65A;
}

_id_FF45D70EF7FD700A(_id_6E784C378272FCAA, attacker, hitloc) {
  _id_687BA52E53E097AC(_id_6E784C378272FCAA, "crash_limb", "crash_torso", "crash_head");
  return 1;
}

_id_A93D4E4D31895D77(_id_6E784C378272FCAA, attacker, hitloc) {
  _id_0988BD2FED09E41C("tag_origin", "akihabara_fatal");
  _id_833113CEB5556A93(_id_6E784C378272FCAA);
  return 1;
}

_id_836E832EF348CB0C(_id_6E784C378272FCAA, attacker, hitloc) {
  if(_id_6E784C378272FCAA isscriptable())
    _id_6E784C378272FCAA setscriptablepartstate("burning", "flareup", 0);

  return 0;
}

_id_F6820874F2F4B7FA(_id_6E784C378272FCAA, attacker, hitloc) {
  if(isdismembermentenabled())
    _id_687BA52E53E097AC(_id_6E784C378272FCAA, "cthulhu_limb", "cthulhu_torso", "cthulhu_head");
  else
    _id_687BA52E53E097AC(_id_6E784C378272FCAA, "cthulhu_nogore_limb", "cthulhu_nogore_torso", "cthulhu_nogore_head");

  return 1;
}

_id_487AD6A4DE40BCF5(_id_6E784C378272FCAA, attacker, hitloc) {
  if(isdismembermentenabled())
    _id_687BA52E53E097AC(_id_6E784C378272FCAA, "hlander_limb", "hlander_torso", "hlander_head");
  else
    _id_687BA52E53E097AC(_id_6E784C378272FCAA, "hlander_nogore_limb", "hlander_nogore_torso", "hlander_nogore_head");

  return 1;
}

_id_AE90D417FBDBA2A9(_id_6E784C378272FCAA, attacker, hitloc) {
  if(hitloc == "head")
    _id_DFCEE2EBE02A6AE7(_id_6E784C378272FCAA, "bnoir_head");
  else
    _id_DFCEE2EBE02A6AE7(_id_6E784C378272FCAA, "bnoir");

  return 0;
}

_id_98C6559ADE501E3D(_id_6E784C378272FCAA, attacker, hitloc) {
  _id_687BA52E53E097AC(_id_6E784C378272FCAA, "nicki_limb", "nicki_torso", "nicki_head");
  return 1;
}

_id_E6385720C367C132(_id_6E784C378272FCAA, attacker, hitloc) {
  if(isdismembermentenabled())
    _id_687BA52E53E097AC(_id_6E784C378272FCAA, "ice_limb", "ice_torso", "ice_head");
  else
    _id_687BA52E53E097AC(_id_6E784C378272FCAA, "ice_nogore_limb", "ice_nogore_torso", "ice_head");

  return 1;
}

_id_BD496CB5C609EBEF(_id_6E784C378272FCAA, attacker, hitloc) {
  if(isdismembermentenabled())
    _id_687BA52E53E097AC(_id_6E784C378272FCAA, "tomb_limb", "tomb_torso", "tomb_head");
  else
    _id_687BA52E53E097AC(_id_6E784C378272FCAA, "tomb_limb_nogore", "tomb_torso_nogore", "tomb_head_nogore");

  return 1;
}

_id_CDAD06C807F2982B(_id_6E784C378272FCAA, attacker, hitloc) {
  _id_687BA52E53E097AC(_id_6E784C378272FCAA, "hips_limb", "hips_torso", "hips_head", "iw9_mp_mtx_hiphop_mic_kill");
  return 1;
}

_id_C05B05634B8BF729(_id_6E784C378272FCAA, attacker, hitloc) {
  _id_687BA52E53E097AC(_id_6E784C378272FCAA, "hops_limb", "hops_torso", "hops_head", "iw9_mp_mtx_hiphop_mic_kill");
  return 1;
}

_id_8E8A14AE1D93C4EA(_id_6E784C378272FCAA, attacker, hitloc) {
  _id_DFCEE2EBE02A6AE7(_id_6E784C378272FCAA, "blunt");
  return 0;
}

_id_54ED38D3B5AC6140(_id_6E784C378272FCAA, attacker, hitloc) {
  if(isdismembermentenabled())
    _id_687BA52E53E097AC(_id_6E784C378272FCAA, "maze_limb", "maze_torso", "maze_head");
  else
    _id_687BA52E53E097AC(_id_6E784C378272FCAA, "maze_nogore_limb", "maze_nogore_torso", "maze_nogore_head");

  return 1;
}

_id_5E562C7C6CD5FBE9(_id_6E784C378272FCAA, attacker, hitloc) {
  _id_0988BD2FED09E41C("j_spinelower", "lilith");
  _id_833113CEB5556A93(_id_6E784C378272FCAA);
  return 1;
}

_id_5B42E2FEAB7A3AAE(_id_6E784C378272FCAA, attacker, hitloc) {
  _id_0988BD2FED09E41C("j_spine4", "lilith");
  _id_833113CEB5556A93(_id_6E784C378272FCAA);
  return 1;
}

_id_5E575CB31776C32F(_id_6E784C378272FCAA, attacker, hitloc) {
  return 0;
}

_id_37D7885E81477F70(_id_6E784C378272FCAA, attacker, hitloc) {
  _id_DFCEE2EBE02A6AE7(_id_6E784C378272FCAA, "skeletor");
  return 0;
}

_id_088E7906B3427CA1(_id_6E784C378272FCAA, attacker, hitloc) {
  _id_687BA52E53E097AC(_id_6E784C378272FCAA, "bcell6_limb", "bcell6_torso", "bcell6_head");
  return 0;
}

_id_7EA50D23AE130CCA(_id_6E784C378272FCAA, attacker, hitloc) {
  _id_0988BD2FED09E41C("j_spine4", "inarius");
  _id_833113CEB5556A93(_id_6E784C378272FCAA);
  return 1;
}

_id_8542D26E5AC6C50C(inflictor) {
  if(scripts\cp_mp\utility\weapon_utility::_id_97DB16DE04046C2B(inflictor, self, "equip_bunkerbuster"))
    return 1;

  return 0;
}

_id_CE7272ACB57AAC2A(_id_6E784C378272FCAA) {
  if(isdismembermentenabled()) {
    _id_687BA52E53E097AC(_id_6E784C378272FCAA, "hlander_limb", "hlander_torso", "hlander_head");
    return 1;
  } else
    return 0;
}

_id_694E1B7805093C52(_id_6E784C378272FCAA) {
  waittillframeend;

  if(self._id_E7A9752E4F4C7D97["ghost_finder_sucking"]) {
    return;
  }
  _id_4A86C2059578EAFF = spawn("script_model", _id_6E784C378272FCAA.origin + (0, 0, 40));
  _id_4A86C2059578EAFF setModel("vfx_scriptable_souleater");
  _id_4A86C2059578EAFF _meth_FCA5BDBE24070D20("soulEater", self.team);
  self._id_E7A9752E4F4C7D97["soul_ents_in_flight"] = scripts\engine\utility::array_add(self._id_E7A9752E4F4C7D97["soul_ents_in_flight"], _id_4A86C2059578EAFF);
  success = _id_F9FFC273B1F19A07(_id_4A86C2059578EAFF);

  if(istrue(success))
    thread _id_54EAAD56EECC69E2();
  else
    _id_671264D7659AB6AB(_id_4A86C2059578EAFF);

  if(isDefined(_id_4A86C2059578EAFF)) {
    if(isDefined(self) && isDefined(self._id_E7A9752E4F4C7D97))
      self._id_E7A9752E4F4C7D97["soul_ents_in_flight"] = scripts\engine\utility::array_remove(self._id_E7A9752E4F4C7D97["soul_ents_in_flight"], _id_4A86C2059578EAFF);

    _id_4A86C2059578EAFF delete();
  }
}

_id_C30CFDFFD08468E1() {
  self notify("stop_soulweapon_swap_logic");
  self endon("stop_soulweapon_swap_logic");
  self endon("death_or_disconnet");
  level endon("game_ended");

  for(;;) {
    self waittill("weapon_switch_started", weapon);

    if(_id_C8F576B523885369(weapon) != "stat_681D1A8FC05751CB")
      self notify("stop_soul_suck");
  }
}

_id_F9FFC273B1F19A07(_id_4A86C2059578EAFF) {
  self endon("death_or_disconnet");
  level endon("game_ended");
  _id_27B0C9AC22B57A8A = gettime();
  movetime = _id_2A5698D5505F5108(_id_4A86C2059578EAFF);
  _id_B7FB5552BBC6A000 = _id_E7680A7E93BEEE63(_id_4A86C2059578EAFF, _id_27B0C9AC22B57A8A, movetime);
  destinationtime = _id_27B0C9AC22B57A8A + movetime + _id_B7FB5552BBC6A000;
  _id_4A86C2059578EAFF.destinationtime = destinationtime;
  _id_4A86C2059578EAFF setscriptablepartstate("soulEater", "hover");
  _id_4A86C2059578EAFF moveTo(_id_4A86C2059578EAFF.origin + (0, 0, 15), 0.7);
  wait(_id_B7FB5552BBC6A000 / 1000);
  _id_4A86C2059578EAFF setscriptablepartstate("soulEater", "suck");
  _id_9F854E807C5CD5AC = gettime();
  _id_7E4A937328305990 = undefined;
  _id_4F356C2154F446C3 = undefined;
  zoffset = undefined;
  yoffset = undefined;
  baseorigin = _id_4A86C2059578EAFF.origin;
  thread _id_01DEC486D84B0373(_id_4A86C2059578EAFF, movetime);

  for(;;) {
    if(!isDefined(self))
      return 0;

    _id_3B5803E733581858 = gettime() - _id_9F854E807C5CD5AC;
    remainingtime = movetime - _id_3B5803E733581858;
    _id_C0F879FCE2BA3932 = min(1, (_id_3B5803E733581858 + level.frameduration) / movetime);
    _id_BC08E2B32A09AB5A = level.frameduration * _id_C0F879FCE2BA3932;

    if(remainingtime > _id_BC08E2B32A09AB5A)
      _id_A26C953F7C94B3EA = _id_BC08E2B32A09AB5A / remainingtime;
    else
      _id_A26C953F7C94B3EA = 1.0;

    if(remainingtime <= 0) {
      break;
    }

    _id_F16CF0133810CF98 = scripts\engine\math::factor_value(5, 0, self playerads());
    f = anglesToForward(self getplayerangles()) * 20;
    _id_AC0E454AC96A77AC = anglestoup(self getplayerangles()) * -9;
    r = anglestoright(self getplayerangles()) * _id_F16CF0133810CF98;
    targetorigin = self getEye() + f + _id_AC0E454AC96A77AC + r;
    _id_83395E644C2F02B1 = targetorigin - baseorigin;
    _id_0C6A939BB6B06ABC = vectorNormalize(_id_83395E644C2F02B1);
    dist = length(_id_83395E644C2F02B1);

    if(!isDefined(_id_7E4A937328305990)) {
      _id_7E4A937328305990 = _id_F9BC9077B9E35705(dist);
      _id_4F356C2154F446C3 = randomfloatrange(-1.5, 1.5) * _id_7E4A937328305990;
    }

    zoffset = _id_AEAC529C62CED2C0(movetime, _id_3B5803E733581858 + level.frameduration, _id_7E4A937328305990);
    yoffset = _id_AEAC529C62CED2C0(movetime, _id_3B5803E733581858 + level.frameduration, _id_4F356C2154F446C3);
    _id_451B84725D725896 = rotatevector(_id_0C6A939BB6B06ABC, (0, 90, 0));
    yoffset = _id_451B84725D725896 * yoffset;
    zoffset = (0, 0, zoffset);
    offset = dist * _id_A26C953F7C94B3EA * _id_0C6A939BB6B06ABC;
    baseorigin = baseorigin + offset;
    _id_4A86C2059578EAFF.origin = baseorigin + zoffset + yoffset;
    waitframe();
  }

  return 1;
}

_id_2A5698D5505F5108(_id_4A86C2059578EAFF) {
  dist = length(_id_4A86C2059578EAFF.origin - self.origin);
  _id_CCBBA16287668F0A = scripts\engine\math::normalize_value(300, 2000, dist);
  return scripts\engine\math::factor_value(0.4, 1.0, _id_CCBBA16287668F0A) * 1000;
}

_id_E7680A7E93BEEE63(_id_4A86C2059578EAFF, _id_27B0C9AC22B57A8A, movetime) {
  self._id_E7A9752E4F4C7D97["soul_ents_in_flight"] = scripts\engine\utility::array_removeundefined(self._id_E7A9752E4F4C7D97["soul_ents_in_flight"]);
  _id_8B7E3D529E9EEC0C = 700.0;

  if(self._id_E7A9752E4F4C7D97["soul_ents_in_flight"][0] == _id_4A86C2059578EAFF)
    return _id_8B7E3D529E9EEC0C;
  else {
    _id_2394D10885BAD3EE = self._id_E7A9752E4F4C7D97["soul_ents_in_flight"][self._id_E7A9752E4F4C7D97["soul_ents_in_flight"].size - 2].destinationtime - _id_27B0C9AC22B57A8A;
    _id_B2CAAE9952CEE2F5 = _id_2394D10885BAD3EE + 300;
    _id_6957FE7344A1B0BC = _id_B2CAAE9952CEE2F5 - movetime * 1000;
    return max(_id_8B7E3D529E9EEC0C, _id_6957FE7344A1B0BC);
  }
}

_id_F9BC9077B9E35705(_id_9C81708EDCFD5D10) {
  _id_CCBBA16287668F0A = scripts\engine\math::normalize_value(300, 1000, _id_9C81708EDCFD5D10);
  return scripts\engine\math::factor_value(7, 25, _id_CCBBA16287668F0A);
}

_id_AEAC529C62CED2C0(movetime, _id_3B5803E733581858, _id_C4C8C6F99AF13350) {
  if(_id_3B5803E733581858 > movetime)
    return 1;

  _id_30C242BD56F50DEC = movetime * 0.5;

  if(_id_3B5803E733581858 > _id_30C242BD56F50DEC)
    frac = (_id_3B5803E733581858 - _id_30C242BD56F50DEC) / _id_30C242BD56F50DEC;
  else {
    frac = _id_3B5803E733581858 / _id_30C242BD56F50DEC;
    frac = 1 - frac;
  }

  frac = frac * frac;
  frac = 1 - frac;
  return frac * _id_C4C8C6F99AF13350;
}

_id_54EAAD56EECC69E2() {
  self endon("death_or_disconnet");
  level endon("game_ended");
  _id_A2FF3959A0B6827E("reactive_soul_collect");
  self._id_E7A9752E4F4C7D97["souls_collected_count"]++;

  if(isDefined(self.currentweapon) && _id_78EDD771B80BB678(self.currentweapon))
    _id_B92E7556D13A2D52();

  wait 0.3;
  _id_B66FA33D64BA4010("reactive_soul_collect_1stage");
}

_id_671264D7659AB6AB(_id_4A86C2059578EAFF) {
  _id_4A86C2059578EAFF setscriptablepartstate("soulEater", "vanish");
}

_id_A628AA1432BDDF36(_id_6E784C378272FCAA) {
  _id_E478AC91AF0E92CB = _id_6E784C378272FCAA getlinkedchildren();

  foreach(child in _id_E478AC91AF0E92CB) {
    if(istrue(child.iscrossbowbolt))
      child scripts\cp_mp\crossbow::boltunlink();

    if(isDefined(child.equipmentref)) {
      switch (child.equipmentref) {
        case "equip_thermite":
        case "equip_semtex":
        case "equip_shockstick":
        case "equip_throwing_knife":
        case "equip_bunkerbuster":
          child unlink();
          break;
        default:
      }
    }
  }
}

_id_01DEC486D84B0373(ent, movetime) {
  self endon("death_or_disconnet");
  level endon("game_ended");
  delay_time = (movetime - 300) / 1000;
  wait(delay_time);

  if(getomnvar("ui_firing_range_has_started") == 1)
    self playSound("iw9_weap_mtx_souleater_absorb");
  else if(isDefined(self.team))
    self playsoundtoteam("iw9_weap_mtx_souleater_absorb", self.team, undefined, self);
  else
    self playsoundtoplayer("iw9_weap_mtx_souleater_absorb", self);
}

_id_687BA52E53E097AC(_id_6E784C378272FCAA, _id_26514DB187811473, _id_525E2544DCF3C43E, _id_FAD07C394421B5F9, sfx, _id_71C779C0BCACE65A) {
  if(!isDefined(_id_71C779C0BCACE65A))
    _id_71C779C0BCACE65A = 1;

  _id_0988BD2FED09E41C("j_shoulder_ri", _id_26514DB187811473);
  _id_0988BD2FED09E41C("j_shoulder_le", _id_26514DB187811473);
  _id_0988BD2FED09E41C("j_elbow_ri", _id_26514DB187811473);
  _id_0988BD2FED09E41C("j_elbow_le", _id_26514DB187811473);
  _id_0988BD2FED09E41C("j_hip_ri", _id_26514DB187811473);
  _id_0988BD2FED09E41C("j_hip_le", _id_26514DB187811473);
  _id_0988BD2FED09E41C("j_knee_ri", _id_26514DB187811473);
  _id_0988BD2FED09E41C("j_knee_le", _id_26514DB187811473);
  _id_0988BD2FED09E41C("j_spineupper", _id_525E2544DCF3C43E);
  _id_0988BD2FED09E41C("j_head", _id_FAD07C394421B5F9);

  if(isDefined(sfx))
    self playSound(sfx);

  if(istrue(_id_71C779C0BCACE65A))
    _id_833113CEB5556A93(_id_6E784C378272FCAA);
}

_id_DFCEE2EBE02A6AE7(_id_6E784C378272FCAA, state) {
  if(_id_6E784C378272FCAA isscriptable() && _id_6E784C378272FCAA getscriptablehaspart("mtxDeath") && _id_6E784C378272FCAA getscriptableparthasstate("mtxDeath", state))
    _id_6E784C378272FCAA setscriptablepartstate("mtxDeath", state, 0);
}

_id_833113CEB5556A93(_id_6E784C378272FCAA) {
  if(!isDefined(_id_6E784C378272FCAA)) {
    return;
  }
  _id_A628AA1432BDDF36(_id_6E784C378272FCAA);

  if(isDefined(_id_6E784C378272FCAA.targetname) && _id_6E784C378272FCAA.targetname == "player_corpse")
    _id_6E784C378272FCAA hide();
  else if(isagent(self))
    thread _id_FAA96C1D7A25FC9C(_id_6E784C378272FCAA);
}

_id_FAA96C1D7A25FC9C(_id_3741EA5B9FB53EC3) {
  waitframe();

  if(isDefined(_id_3741EA5B9FB53EC3))
    _id_3741EA5B9FB53EC3 delete();
}

_id_0988BD2FED09E41C(tag, fx) {
  if(self tagexists(tag)) {
    org = self gettagorigin(tag);
    _id_8BC14603A27FA3E7 = self gettagangles(tag);
    playFX(level._effect[fx], org, anglesToForward(_id_8BC14603A27FA3E7), anglestoup(_id_8BC14603A27FA3E7));
  }
}

_id_5B5E6DE151E0FECD(value) {
  self._id_E7A9752E4F4C7D97["mtx_scriptable_charm_state"] = value;
}

_id_6B2D1CC6BC7C8A90(value) {
  self._id_E7A9752E4F4C7D97["mtx_scriptable_gunscreen_state"] = value;
}

_id_4F0C5ACD6343C0DD(name, value) {
  _id_3BD8D57C42967DFC();

  if(!isDefined(self._id_E7A9752E4F4C7D97["mtx_SCRIPTABLE_REACTIVE_IDs"]))
    self._id_E7A9752E4F4C7D97["mtx_SCRIPTABLE_REACTIVE_IDs"] = [];

  if(!isDefined(self._id_E7A9752E4F4C7D97["mtx_SCRIPTABLE_REACTIVE_IDs"][name]))
    self._id_E7A9752E4F4C7D97["mtx_SCRIPTABLE_REACTIVE_IDs"][name] = value;
}

_id_68444E56728A13A6(name, value) {
  _id_3BD8D57C42967DFC();

  if(!isDefined(self._id_E7A9752E4F4C7D97["mtx_SCRIPTABLE_REACTIVE_IDs"]))
    self._id_E7A9752E4F4C7D97["mtx_scriptable_toggle_ids"] = [];

  if(!isDefined(self._id_E7A9752E4F4C7D97["mtx_SCRIPTABLE_REACTIVE_IDs"][name]))
    self._id_E7A9752E4F4C7D97["mtx_scriptable_toggle_ids"][name] = "toggle0";
}

_id_035C927994920A75(name, value) {
  _id_3BD8D57C42967DFC();

  if(!isDefined(self._id_E7A9752E4F4C7D97[name]))
    self._id_E7A9752E4F4C7D97[name] = value;
}

_id_3BD8D57C42967DFC() {
  if(!isDefined(self._id_E7A9752E4F4C7D97))
    self._id_E7A9752E4F4C7D97 = [];
}

_id_D4E4935B9938F870() {
  self._id_E7A9752E4F4C7D97["kill_streak"] = 0;
  self._id_E7A9752E4F4C7D97["reactive_kills"] = self._id_E7A9752E4F4C7D97["match_kills"];
  self._id_E7A9752E4F4C7D97["downgradable_kill_streak"] = 0;
  self._id_E7A9752E4F4C7D97["kill_streak_weapon"] = [];
  self._id_E7A9752E4F4C7D97["all_scriptable_disablers"] = [];
  self._id_E7A9752E4F4C7D97["direct_scriptable_disablers"] = [];
  self._id_E7A9752E4F4C7D97["souls_collected_count"] = 0;
}

_id_488022F64344D044(_id_A9C0C2F18A5358F3, _id_C970E3384AD6B8A5) {
  if(_id_A9C0C2F18A5358F3 >= _id_C970E3384AD6B8A5)
    return 1;

  return 0;
}

_id_F5E12EE66DF3A2C2(ref) {
  self._id_E7A9752E4F4C7D97[ref]++;
}

_id_6C5F91D778849D7C(ref) {
  self._id_E7A9752E4F4C7D97[ref] = 0;
}

_id_1B411DFEDDEC6105(_id_6E784C378272FCAA, hitloc) {
  if((hitloc == "head" || hitloc == "helmet") && isdismembermentenabled())
    _id_DFCEE2EBE02A6AE7(_id_6E784C378272FCAA, "halloweenHeadpop");
}

_id_088B034261873044() {
  if(getdvarint("mgl", 0) != 0) {
    level._effect["vfx_mgl_sbandit_inspect_anim.vfx"] = loadfx("vfx/mgl/iw9/core/weapons/animations/inspect/vfx_mgl_sbandit_inspect_anim.vfx");
    level._effect["vfx_mgl_sbandit_inspect_anim_ch01"] = loadfx("vfx/mgl/iw9/core/weapons/animations/inspect/vfx_mgl_sbandit_inspect_anim_ch01.vfx");
    level._effect["vfx_mgl_sbandit_inspect_anim_02"] = loadfx("vfx/mgl/iw9/core/weapons/animations/inspect/vfx_mgl_sbandit_inspect_anim_02.vfx");
    level._effect["vfx_mgl_sbandit_inspect_anim_ch02"] = loadfx("vfx/mgl/iw9/core/weapons/animations/inspect/vfx_mgl_sbandit_inspect_anim_ch02.vfx");
    level._effect["vfx_mgl_sbandit_inspect_anim_ch03"] = loadfx("vfx/mgl/iw9/core/weapons/animations/inspect/vfx_mgl_sbandit_inspect_anim_ch03.vfx");
    level._effect["vfx_mgl_sbandit_reload_anim_01.vfx"] = loadfx("vfx/mgl/iw9/core/weapons/animations/reload/vfx_mgl_sbandit_reload_anim_01.vfx");
    level._effect["vfx_mgl_sbandit_reload_anim_02.vfx"] = loadfx("vfx/mgl/iw9/core/weapons/animations/reload/vfx_mgl_sbandit_reload_anim_02.vfx");
    level._effect["vfx_inspect_mtx_alpha50_spider_01"] = loadfx("vfx/mgl/iw9/core/weapons/animations/inspect/vfx_inspect_mtx_alpha50_spider_01.vfx");
    level._effect["vfx_inspect_mtx_alpha50_spider_02"] = loadfx("vfx/mgl/iw9/core/weapons/animations/inspect/vfx_inspect_mtx_alpha50_spider_02.vfx");
    level._effect["vfx_inspect_mtx_alpha50_spider_03"] = loadfx("vfx/mgl/iw9/core/weapons/animations/inspect/vfx_inspect_mtx_alpha50_spider_03.vfx");
    level._effect["vfx_inspect_mtx_mike4_arcstorm_01"] = loadfx("vfx/mgl/iw9/core/weapons/animations/inspect/vfx_inspect_mtx_mike4_arcstorm_01.vfx");
    level._effect["vfx_inspect_mtx_mike4_arcstorm_02"] = loadfx("vfx/mgl/iw9/core/weapons/animations/inspect/vfx_inspect_mtx_mike4_arcstorm_02.vfx");
    level._effect["vfx_inspect_mtx_mike4_arcstorm_03"] = loadfx("vfx/mgl/iw9/core/weapons/animations/inspect/vfx_inspect_mtx_mike4_arcstorm_03.vfx");
    level._effect["vfx_inspect_mtx_mike4_arcstorm_04"] = loadfx("vfx/mgl/iw9/core/weapons/animations/inspect/vfx_inspect_mtx_mike4_arcstorm_04.vfx");
    level._effect["vfx_inspect_mtx_mike4_arcstorm_05"] = loadfx("vfx/mgl/iw9/core/weapons/animations/inspect/vfx_inspect_mtx_mike4_arcstorm_05.vfx");
    level._effect["vfx_inspect_mtx_mike4_arcstorm_06"] = loadfx("vfx/mgl/iw9/core/weapons/animations/inspect/vfx_inspect_mtx_mike4_arcstorm_06.vfx");
    level._effect["vfx_inspect_mtx_mike4_arcstorm_07"] = loadfx("vfx/mgl/iw9/core/weapons/animations/inspect/vfx_inspect_mtx_mike4_arcstorm_07.vfx");
    level._effect["vfx_imp_mtx_spaceignition_gen_ch01.vfx"] = loadfx("vfx/mgl/iw9/core/weapons/impacts/mtx/vfx_imp_mtx_spaceignition_gen_ch01.vfx");
    level._effect["vfx_mgl_spaceIgnition_inspect_anim_skull.vfx"] = loadfx("vfx/mgl/iw9/core/weapons/animations/inspect/vfx_mgl_spaceIgnition_inspect_anim_skull.vfx");
    level._effect["vfx_mgl_spaceIgnition_inspect_anim_Main.vfx"] = loadfx("vfx/mgl/iw9/core/weapons/animations/inspect/vfx_mgl_spaceIgnition_inspect_anim_Main.vfx");
    level._effect["vfx_mgl_spaceignition_inspect_anim.vfx"] = loadfx("vfx/mgl/iw9/core/weapons/animations/inspect/vfx_mgl_spaceignition_inspect_anim.vfx");
    level._effect["vfx_imp_mtx_spaceIgnition_skull_explo.vfx"] = loadfx("vfx/mgl/iw9/core/weapons/animations/inspect/vfx_imp_mtx_spaceIgnition_skull_explo.vfx");
    level._effect["vfx_mgl_spaceIgnition_inspect_anim_blade.vfx"] = loadfx("vfx/mgl/iw9/core/weapons/animations/inspect/vfx_mgl_spaceIgnition_inspect_anim_blade.vfx");
    level._effect["vfx_mtx_spaceignition_burst_energy.vfx"] = loadfx("vfx/mgl/iw9/core/weapons/animations/inspect/vfx_mtx_spaceignition_burst_energy.vfx");
    level._effect["vfx_mgl_slatedprism_inspect_anim_01"] = loadfx("vfx/mgl/iw9/core/weapons/animations/inspect/vfx_mgl_slatedprism_inspect_anim_01.vfx");
    level._effect["vfx_mgl_slatedprism_inspect_anim_02"] = loadfx("vfx/mgl/iw9/core/weapons/animations/inspect/vfx_mgl_slatedprism_inspect_anim_02.vfx");
    level._effect["vfx_mgl_slatedprism_inspect_anim_03"] = loadfx("vfx/mgl/iw9/core/weapons/animations/inspect/vfx_mgl_slatedprism_inspect_anim_03.vfx");
    level._effect["vfx_mgl_slatedprism_reload_anim_01"] = loadfx("vfx/mgl/iw9/core/weapons/animations/reload/vfx_mgl_slatedprism_reload_anim_01.vfx");
    level._effect["vfx_mgl_slatedprism_reload_anim_02"] = loadfx("vfx/mgl/iw9/core/weapons/animations/reload/vfx_mgl_slatedprism_reload_anim_02.vfx");
    level._effect["vfx_mgl_cyberviking_inspect_anim_Main"] = loadfx("vfx/mgl/iw9/core/weapons/animations/inspect/vfx_mgl_cyberviking_inspect_anim_Main.vfx");
    level._effect["vfx_mgl_cyberviking_inspect_anim_portal"] = loadfx("vfx/mgl/iw9/core/weapons/animations/inspect/vfx_mgl_cyberviking_inspect_anim_portal.vfx");
    level._effect["vfx_mgl_crytempest_reload_anim_01"] = loadfx("vfx/mgl/iw9/core/weapons/animations/reload/vfx_mgl_crytempest_reload_anim_01.vfx");
    level._effect["vfx_mgl_crytempest_reload_anim_02"] = loadfx("vfx/mgl/iw9/core/weapons/animations/reload/vfx_mgl_crytempest_reload_anim_02.vfx");
    level._effect["vfx_mgl_crytempest_reload_anim_03"] = loadfx("vfx/mgl/iw9/core/weapons/animations/reload/vfx_mgl_crytempest_reload_anim_03.vfx");
    level._effect["vfx_mgl_crytempest_reload_anim_04"] = loadfx("vfx/mgl/iw9/core/weapons/animations/reload/vfx_mgl_crytempest_reload_anim_04.vfx");
    level._effect["vfx_mgl_crytempest_reload_anim_05"] = loadfx("vfx/mgl/iw9/core/weapons/animations/reload/vfx_mgl_crytempest_reload_anim_05.vfx");
    level._effect["vfx_mgl_crytempest_inspect_anim_01"] = loadfx("vfx/mgl/iw9/core/weapons/animations/inspect/vfx_mgl_crytempest_inspect_anim_01.vfx");
    level._effect["vfx_mgl_crytempest_inspect_anim_02"] = loadfx("vfx/mgl/iw9/core/weapons/animations/inspect/vfx_mgl_crytempest_inspect_anim_02.vfx");
    level._effect["vfx_weapon_reactive_banshee_ch_vm"] = loadfx("vfx/mgl/iw9/core/weapons/reactive/vfx_weapon_reactive_banshee_ch_vm.vfx");
    level._effect["vfx_mgl_banshee_reload_anim"] = loadfx("vfx/mgl/iw9/core/weapons/animations/reload/vfx_mgl_banshee_reload_anim.vfx");
    level._effect["vfx_mgl_banshee_inspect_anim"] = loadfx("vfx/mgl/iw9/core/weapons/animations/inspect/vfx_mgl_banshee_inspect_anim.vfx");
  }
}