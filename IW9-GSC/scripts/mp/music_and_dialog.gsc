/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\music_and_dialog.gsc
***********************************************/

init() {
  _id_D0C04D2061F1E80A();
  _id_ED24376A19A1B0FE();
  _id_AAB0CD8461430413();
  _id_6CA37AF6683E78EC();
}

_id_D0C04D2061F1E80A() {
  if(istrue(game["isLaunchChunk"]))
    _id_AE34C52213832650 = "ustl";
  else
    _id_AE34C52213832650 = "uktl";

  if(isDefined(level.alliessquadleader))
    _id_AE34C52213832650 = level.alliessquadleader;

  _id_B24C891508E7C927 = "rutl";

  if(isDefined(level.axissquadleader))
    _id_B24C891508E7C927 = level.axissquadleader;

  if(!isDefined(game["voice"])) {
    game["voice"]["allies"] = _id_AE34C52213832650;
    game["voice"]["axis"] = _id_B24C891508E7C927;
  }
}

_id_AAB0CD8461430413() {
  if(!isDefined(game["music"])) {
    _id_7AB5B649FA408138::_id_B11CFEE3350D246A("allies_used_nuke", "mus_us_nuke_fired");
    _id_7AB5B649FA408138::_id_B11CFEE3350D246A("allies_hit_by_nuke", "mus_us_nuke_hit");

    if(_id_7AB5B649FA408138::_id_5DF2F278F44A6FFD("middle_east")) {
      _id_B41695C9593199E8 = ["prematch_mp_infil_1", "prematch_mp_infil_2", "prematch_mp_infil_3", "prematch_mp_infil_4", "prematch_mp_infil_5", "prematch_mp_infil_6", "prematch_mp_infil_7", "prematch_mp_infil_8"];
      _id_7AB5B649FA408138::_id_B11CFEE3350D246A("spawn_axis", _id_B41695C9593199E8);
    } else if(_id_7AB5B649FA408138::_id_5DF2F278F44A6FFD("mexico")) {
      _id_B41695C9593199E8 = ["prematch_mp_infil_1", "prematch_mp_infil_2", "prematch_mp_infil_3", "prematch_mp_infil_4", "prematch_mp_infil_5", "prematch_mp_infil_6", "prematch_mp_infil_7", "prematch_mp_infil_8"];
      _id_7AB5B649FA408138::_id_B11CFEE3350D246A("spawn_axis", _id_B41695C9593199E8);
    } else {
      _id_B41695C9593199E8 = ["prematch_mp_infil_1", "prematch_mp_infil_2", "prematch_mp_infil_3", "prematch_mp_infil_4", "prematch_mp_infil_5", "prematch_mp_infil_6", "prematch_mp_infil_7", "prematch_mp_infil_8"];
      _id_7AB5B649FA408138::_id_B11CFEE3350D246A("spawn_axis", _id_B41695C9593199E8);
    }

    _id_7AB5B649FA408138::_id_B11CFEE3350D246A("defeat_axis", "mx_mp_generic_lose_2");
    _id_7AB5B649FA408138::_id_B11CFEE3350D246A("defeat_axis_fade", "mx_mp_generic_lose_2");
    _id_7AB5B649FA408138::_id_B11CFEE3350D246A("victory_axis", "mx_mp_generic_win_1");
    _id_7AB5B649FA408138::_id_B11CFEE3350D246A("victory_axis_fade", "mx_mp_generic_win_1");
    _id_7AB5B649FA408138::_id_B11CFEE3350D246A("draw_axis", "mx_mp_generic_draw_1");

    if(_id_7AB5B649FA408138::_id_5DF2F278F44A6FFD("middle_east")) {
      _id_7AB5B649FA408138::_id_B11CFEE3350D246A("defeat_axis", "mx_mp_mideast_lose_2");
      _id_7AB5B649FA408138::_id_B11CFEE3350D246A("defeat_axis_fade", "mx_mp_mideast_lose_2");
      _id_7AB5B649FA408138::_id_B11CFEE3350D246A("victory_axis", "mx_mp_mideast_win_2");
      _id_7AB5B649FA408138::_id_B11CFEE3350D246A("victory_axis_fade", "mx_mp_mideast_win_2");
      _id_7AB5B649FA408138::_id_B11CFEE3350D246A("draw_axis", "mx_mp_mideast_draw_2");
    }

    if(_id_7AB5B649FA408138::_id_5DF2F278F44A6FFD("mexico")) {
      _id_7AB5B649FA408138::_id_B11CFEE3350D246A("defeat_axis", "mx_mp_mexico_lose_1");
      _id_7AB5B649FA408138::_id_B11CFEE3350D246A("defeat_axis_fade", "mx_mp_mexico_lose_1");
      _id_7AB5B649FA408138::_id_B11CFEE3350D246A("victory_axis", "mx_mp_mexico_win_1");
      _id_7AB5B649FA408138::_id_B11CFEE3350D246A("victory_axis_fade", "mx_mp_mexico_win_1");
      _id_7AB5B649FA408138::_id_B11CFEE3350D246A("draw_axis", "mx_mp_mexico_draw_2");
    }

    _id_F1BCFF5BB49B73D9 = ["mx_mp_mexico_timesup_win_2", "mx_mp_mexico_timesup_win_4", "mx_mp_generic_timesup_win_1", "mx_mp_generic_timesup_win_2", "mx_mp_mideast_timesup_win_1"];
    _id_7AB5B649FA408138::_id_B11CFEE3350D246A("winning_axis", _id_F1BCFF5BB49B73D9);
    _id_7A74F0F97389ED99 = ["mp_round_win_playlist"];
    _id_7AB5B649FA408138::_id_B11CFEE3350D246A("roundwin_axis", _id_7A74F0F97389ED99);
    _id_B9F676BCFD9C687C = ["mp_round_lose_playlist"];
    _id_7AB5B649FA408138::_id_B11CFEE3350D246A("roundloss_axis", _id_B9F676BCFD9C687C);
    _id_0B859892416A15F1 = ["mx_mp_mexico_timesup_lose_1", "mx_mp_mideast_timesup_lose_2", "mx_mp_mexico_timesup_win_2", "mx_mp_mexico_timesup_win_4"];
    _id_7AB5B649FA408138::_id_B11CFEE3350D246A("losing_axis", _id_0B859892416A15F1);

    if(_id_7AB5B649FA408138::_id_5DF2F278F44A6FFD("middle_east")) {
      _id_39D6886350FA21AB = ["prematch_mp_infil_1", "prematch_mp_infil_2", "prematch_mp_infil_3", "prematch_mp_infil_4", "prematch_mp_infil_5", "prematch_mp_infil_6", "prematch_mp_infil_7", "prematch_mp_infil_8"];
      _id_7AB5B649FA408138::_id_B11CFEE3350D246A("spawn_allies", _id_39D6886350FA21AB);
    } else if(_id_7AB5B649FA408138::_id_5DF2F278F44A6FFD("mexico")) {
      _id_39D6886350FA21AB = ["prematch_mp_infil_1", "prematch_mp_infil_2", "prematch_mp_infil_3", "prematch_mp_infil_4", "prematch_mp_infil_5", "prematch_mp_infil_6", "prematch_mp_infil_7", "prematch_mp_infil_8"];
      _id_7AB5B649FA408138::_id_B11CFEE3350D246A("spawn_allies", _id_39D6886350FA21AB);
    } else {
      _id_39D6886350FA21AB = ["prematch_mp_infil_1", "prematch_mp_infil_2", "prematch_mp_infil_3", "prematch_mp_infil_4", "prematch_mp_infil_5", "prematch_mp_infil_6", "prematch_mp_infil_7", "prematch_mp_infil_8"];
      _id_7AB5B649FA408138::_id_B11CFEE3350D246A("spawn_allies", _id_39D6886350FA21AB);
    }

    _id_7AB5B649FA408138::_id_B11CFEE3350D246A("defeat_allies", "mx_mp_generic_lose_1");
    _id_7AB5B649FA408138::_id_B11CFEE3350D246A("defeat_allies_fade", "mx_mp_generic_lose_1");
    _id_7AB5B649FA408138::_id_B11CFEE3350D246A("victory_allies", "mx_mp_generic_win_2");
    _id_7AB5B649FA408138::_id_B11CFEE3350D246A("victory_allies_fade", "mx_mp_generic_win_2");
    _id_7AB5B649FA408138::_id_B11CFEE3350D246A("draw_allies", "mx_mp_generic_draw_2");

    if(_id_7AB5B649FA408138::_id_5DF2F278F44A6FFD("middle_east")) {
      _id_7AB5B649FA408138::_id_B11CFEE3350D246A("defeat_allies", "mx_mp_mideast_lose_1");
      _id_7AB5B649FA408138::_id_B11CFEE3350D246A("defeat_allies_fade", "mx_mp_mideast_lose_1");
      _id_7AB5B649FA408138::_id_B11CFEE3350D246A("victory_allies", "mx_mp_mideast_win_1");
      _id_7AB5B649FA408138::_id_B11CFEE3350D246A("victory_allies_fade", "mx_mp_mideast_win_1");
      _id_7AB5B649FA408138::_id_B11CFEE3350D246A("draw_allies", "mx_mp_mideast_draw_1");
    }

    if(_id_7AB5B649FA408138::_id_5DF2F278F44A6FFD("mexico")) {
      _id_7AB5B649FA408138::_id_B11CFEE3350D246A("defeat_allies", "mx_mp_mexico_lose_2");
      _id_7AB5B649FA408138::_id_B11CFEE3350D246A("defeat_allies_fade", "mx_mp_mexico_lose_2");
      _id_7AB5B649FA408138::_id_B11CFEE3350D246A("victory_allies", "mx_mp_mexico_win_2");
      _id_7AB5B649FA408138::_id_B11CFEE3350D246A("victory_allies_fade", "mx_mp_mexico_win_2");
      _id_7AB5B649FA408138::_id_B11CFEE3350D246A("draw_allies", "mx_mp_mexico_draw_1");
    }

    _id_809968286B16012E = ["mx_mp_mexico_timesup_win_2", "mx_mp_mexico_timesup_win_4", "mx_mp_generic_timesup_win_1", "mx_mp_generic_timesup_win_2", "mx_mp_mideast_timesup_win_1"];
    _id_7AB5B649FA408138::_id_B11CFEE3350D246A("winning_allies", _id_809968286B16012E);
    _id_48CAADA842FC5DF7 = ["mp_round_lose_playlist"];
    _id_7AB5B649FA408138::_id_B11CFEE3350D246A("roundloss_allies", _id_48CAADA842FC5DF7);
    _id_5C4AF3CBE0A030EE = ["mp_round_win_playlist"];
    _id_7AB5B649FA408138::_id_B11CFEE3350D246A("roundwin_allies", _id_5C4AF3CBE0A030EE);
    _id_83EB6DB3E01FA1B6 = ["mx_mp_mexico_timesup_lose_1", "mx_mp_mideast_timesup_lose_2", "mx_mp_mexico_timesup_win_2", "mx_mp_mexico_timesup_win_4"];
    _id_7AB5B649FA408138::_id_B11CFEE3350D246A("losing_allies", _id_83EB6DB3E01FA1B6);
    _id_E13DA16D3D6BC87E = ["mx_mp_generic_midpoint_winning_1", "mx_mp_generic_midpoint_winning_2"];
    _id_7AB5B649FA408138::_id_B11CFEE3350D246A("midpoint_winning", _id_E13DA16D3D6BC87E);
    _id_894F38A130343410 = ["mx_mp_generic_midpoint_losing_1", "mx_mp_generic_midpoint_losing_2"];
    _id_7AB5B649FA408138::_id_B11CFEE3350D246A("midpoint_losing", _id_894F38A130343410);

    foreach(_id_F90358454413407F in level.teamnamelist) {
      if(_id_F90358454413407F == "axis" || _id_F90358454413407F == "allies") {
        continue;
      }
      _id_7AB5B649FA408138::_id_B11CFEE3350D246A("defeat_" + _id_F90358454413407F, "mp_lose_1");
      _id_7AB5B649FA408138::_id_B11CFEE3350D246A("victory_" + _id_F90358454413407F, "mp_win_2");
      _id_7AB5B649FA408138::_id_B11CFEE3350D246A("winning_" + _id_F90358454413407F, "mus_west_winning");
      _id_7AB5B649FA408138::_id_B11CFEE3350D246A("losing_" + _id_F90358454413407F, "mus_west_losing");
    }

    _id_1D15528DAA831962();
  }
}

_id_1D15528DAA831962() {
  _id_A3A7E3CDA3FF7E8E = ["prematch_mp_infil_1", "prematch_mp_infil_2", "prematch_mp_infil_3", "prematch_mp_infil_4", "prematch_mp_infil_5", "prematch_mp_infil_6", "prematch_mp_infil_7", "prematch_mp_infil_8"];
  _id_7AB5B649FA408138::_id_B11CFEE3350D246A("snatch_spawn", _id_A3A7E3CDA3FF7E8E);
  _id_C5928F7E9D1E509D = ["mx_mp_gunfight_west_fists_infil_1", "mx_mp_gunfight_west_fists_infil_2", "mx_mp_gunfight_east_fists_infil_1", "mx_mp_gunfight_east_fists_infil_2"];
  _id_7AB5B649FA408138::_id_B11CFEE3350D246A("gunfight_spawn", _id_C5928F7E9D1E509D);
  _id_B8FAB4E50ED900A4 = ["mx_mp_gunfight_fists_early_win_1", "mx_mp_gunfight_fists_early_win_2"];
  _id_7AB5B649FA408138::_id_B11CFEE3350D246A("gunfight_roundwin_early", _id_B8FAB4E50ED900A4);
  _id_68798F2D7611DD71 = ["mx_mp_gunfight_fists_early_loss_1", "mx_mp_gunfight_fists_early_loss_2"];
  _id_7AB5B649FA408138::_id_B11CFEE3350D246A("gunfight_roundloss_early", _id_68798F2D7611DD71);
  _id_3289D1165BE19D4D = ["mx_mp_gunfight_fists_mid_win_1", "mx_mp_gunfight_fists_mid_win_2"];
  _id_7AB5B649FA408138::_id_B11CFEE3350D246A("gunfight_roundwin_mid", _id_3289D1165BE19D4D);
  _id_B27885B7781881B8 = ["mx_mp_gunfight_fists_mid_loss_1", "mx_mp_gunfight_fists_mid_loss_2"];
  _id_7AB5B649FA408138::_id_B11CFEE3350D246A("gunfight_roundloss_mid", _id_B27885B7781881B8);
  _id_BE3E4C3DB77C56C9 = ["mx_mp_gunfight_fists_late_win_1", "mx_mp_gunfight_fists_late_win_2"];
  _id_7AB5B649FA408138::_id_B11CFEE3350D246A("gunfight_roundwin_late", _id_BE3E4C3DB77C56C9);
  _id_58979760CF2829BE = ["mx_mp_gunfight_fists_late_loss_1", "mx_mp_gunfight_fists_late_loss_2"];
  _id_7AB5B649FA408138::_id_B11CFEE3350D246A("gunfight_roundloss_late", _id_58979760CF2829BE);

  if(_id_7AB5B649FA408138::_id_5DF2F278F44A6FFD("middle_east")) {
    _id_E8C7CF1D8FD6FFDC = ["mx_dominated_0", "mx_dominated_1", "mx_dominated_2", "mx_mideast_dominated_0"];
    _id_7AB5B649FA408138::_id_B11CFEE3350D246A("dominated_axis", _id_E8C7CF1D8FD6FFDC);
  } else {
    _id_E8C7CF1D8FD6FFDC = ["mx_dominated_0", "mx_dominated_1", "mx_dominated_2"];
    _id_7AB5B649FA408138::_id_B11CFEE3350D246A("dominated_axis", _id_E8C7CF1D8FD6FFDC);
  }

  _id_77162852713D34B9 = ["mx_dominating_0", "mx_dominating_1", "mx_dominating_2"];
  _id_7AB5B649FA408138::_id_B11CFEE3350D246A("dominating_axis", _id_77162852713D34B9);

  if(_id_7AB5B649FA408138::_id_5DF2F278F44A6FFD("middle_east")) {
    _id_5E23D83C64A2C857 = ["mx_dominated_0", "mx_dominated_1", "mx_dominated_2", "mx_mideast_dominated_0"];
    _id_7AB5B649FA408138::_id_B11CFEE3350D246A("dominated_allies", _id_5E23D83C64A2C857);
  } else {
    _id_5E23D83C64A2C857 = ["mx_dominated_0", "mx_dominated_1", "mx_dominated_2"];
    _id_7AB5B649FA408138::_id_B11CFEE3350D246A("dominated_allies", _id_5E23D83C64A2C857);
  }

  _id_7B072BE2D819130E = ["mx_dominating_0", "mx_dominating_1", "mx_dominating_2"];
  _id_7AB5B649FA408138::_id_B11CFEE3350D246A("dominating_allies", _id_7B072BE2D819130E);
  _id_552EC565648D80DA = ["mp_sd_bombplanted_playlist"];
  _id_7AB5B649FA408138::_id_B11CFEE3350D246A("bombplant", _id_552EC565648D80DA);
  _id_BEABA493B37AB4FC = ["mp_sd_bombplanted_30_playlist"];
  _id_7AB5B649FA408138::_id_B11CFEE3350D246A("bombplant_30", _id_BEABA493B37AB4FC);
  _id_77F6366828E665EA = ["mp_sd_bombplanted_30_playlist"];
  _id_7AB5B649FA408138::_id_B11CFEE3350D246A("bounty_music", _id_77F6366828E665EA);
  _id_1727D0AC1471DA03 = ["mp_hp_new_playlist"];
  _id_7AB5B649FA408138::_id_B11CFEE3350D246A("hq_new", _id_1727D0AC1471DA03);
  _id_611D2B9DA9EDEA1D = ["mp_hp_captured_playlist"];
  _id_7AB5B649FA408138::_id_B11CFEE3350D246A("hq_captured", _id_611D2B9DA9EDEA1D);
  _id_02F4D95AB8379C4F = ["mp_hp_destroy_enemy"];
  _id_7AB5B649FA408138::_id_B11CFEE3350D246A("hq_destroyed_pos", _id_02F4D95AB8379C4F);
  _id_4FE7F7597961AB1F = ["mp_hp_destroy_team"];
  _id_7AB5B649FA408138::_id_B11CFEE3350D246A("hq_destroyed_neg", _id_4FE7F7597961AB1F);
  _id_967EC7E06AE0CA71 = ["mp_infil_2", "mp_infil_3", "mp_infil_4", "mp_infil_5", "mp_infil_6", "mp_infil_8", "mx_mp_generic_infil_1", "mx_mp_generic_infil_2", "mx_mp_generic_infil_4", "mx_mp_generic_infil_5", "mx_mp_generic_infil_6", "mx_mp_generic_infil_8", "mx_mp_generic_infil_9", "mx_mp_generic_infil_11", "mx_mp_generic_infil_12", "mx_mp_generic_infil_13", "mx_mp_generic_infil_14", "mx_mp_generic_infil_15", "mx_mp_generic_infil_16"];

  if(_id_7AB5B649FA408138::_id_5DF2F278F44A6FFD("middle_east")) {
    _id_19C1B4C91C5485AD = ["mx_mp_mideast_infil_3", "mx_mp_mideast_infil_7", "mx_mp_mideast_infil_8"];
    _id_967EC7E06AE0CA71 = scripts\engine\utility::array_combine(_id_967EC7E06AE0CA71, _id_19C1B4C91C5485AD);
  }

  if(_id_7AB5B649FA408138::_id_5DF2F278F44A6FFD("mexico")) {
    _id_C831B9C778E478ED = ["mx_mp_mexico_infil_1", "mx_mp_mexico_infil_3", "mx_mp_mexico_infil_4", "mx_mp_mexico_infil_5", "mx_mp_mexico_infil_6", "mx_mp_mexico_infil_9", "mx_mp_mexico_infil_10", "mx_mp_mexico_infil_11"];
    _id_967EC7E06AE0CA71 = _id_C831B9C778E478ED;
  }

  _id_7AB5B649FA408138::_id_B11CFEE3350D246A("east_animated_infil", _id_967EC7E06AE0CA71);
  _id_B27BD19DDA4DB8D3 = ["mp_infil_2", "mp_infil_3", "mp_infil_4", "mp_infil_5", "mp_infil_6", "mp_infil_8", "mx_mp_generic_infil_1", "mx_mp_generic_infil_2", "mx_mp_generic_infil_3", "mx_mp_generic_infil_4", "mx_mp_generic_infil_6", "mx_mp_generic_infil_7", "mx_mp_generic_infil_8", "mx_mp_generic_infil_9", "mx_mp_generic_infil_11", "mx_mp_generic_infil_12", "mx_mp_generic_infil_14", "mx_mp_generic_infil_15", "mx_mp_generic_infil_16"];

  if(_id_7AB5B649FA408138::_id_5DF2F278F44A6FFD("middle_east")) {
    _id_16800442BBFC8613 = ["mx_mp_mideast_infil_3", "mx_mp_mideast_infil_7", "mx_mp_mideast_infil_8"];
    _id_B27BD19DDA4DB8D3 = scripts\engine\utility::array_combine(_id_B27BD19DDA4DB8D3, _id_16800442BBFC8613);
  }

  if(_id_7AB5B649FA408138::_id_5DF2F278F44A6FFD("mexico")) {
    _id_675A6A3F175270FF = ["mx_mp_mexico_infil_1", "mx_mp_mexico_infil_3", "mx_mp_mexico_infil_4", "mx_mp_mexico_infil_5", "mx_mp_mexico_infil_6", "mx_mp_mexico_infil_9", "mx_mp_mexico_infil_10", "mx_mp_mexico_infil_11"];
    _id_B27BD19DDA4DB8D3 = _id_675A6A3F175270FF;
  }

  _id_7AB5B649FA408138::_id_B11CFEE3350D246A("west_animated_infil", _id_B27BD19DDA4DB8D3);
  _id_15F746FDB4DFF132 = ["br_plunder_tenpercent_1", "br_plunder_tenpercent_2"];
  _id_7AB5B649FA408138::_id_B11CFEE3350D246A("plunder_tenpercent", _id_15F746FDB4DFF132);
  _id_438BEA8ED781A1FB = ["br_plunder_thirtypercent_1", "br_plunder_thirtypercent_2"];
  _id_7AB5B649FA408138::_id_B11CFEE3350D246A("plunder_thirtypercent", _id_438BEA8ED781A1FB);
  _id_365A67710A61DED9 = ["br_plunder_fiftypercent_1", "br_plunder_fiftypercent_2"];
  _id_7AB5B649FA408138::_id_B11CFEE3350D246A("plunder_fiftypercent", _id_365A67710A61DED9);
  _id_E960F7DC3C1248A5 = ["br_plunder_seventyfivepercent_1", "br_plunder_seventyfivepercent_2", "br_plunder_seventyfivepercent_3"];
  _id_7AB5B649FA408138::_id_B11CFEE3350D246A("plunder_seventyfivepercent", _id_E960F7DC3C1248A5);
  _id_CF8ED183858037FA = ["br_plunder_ninetypercent_3", "br_plunder_ninetypercent_4", "br_plunder_ninetypercent_5"];
  _id_7AB5B649FA408138::_id_B11CFEE3350D246A("plunder_ninetypercent", _id_CF8ED183858037FA);
  _id_48B0DC7795AA3BE3 = ["br_plunder_bonustime_long"];
  _id_7AB5B649FA408138::_id_B11CFEE3350D246A("plunder_bonustime_long", _id_48B0DC7795AA3BE3);
  _id_7AB5B649FA408138::_id_B11CFEE3350D246A("axis_used_nuke", "mus_fd_nuke_fired");
  _id_7AB5B649FA408138::_id_B11CFEE3350D246A("axis_hit_by_nuke", "mus_fd_nuke_hit");
  _id_C31C0E4113B9CD1E = ["mp_round_lose_playlist"];
  _id_7AB5B649FA408138::_id_B11CFEE3350D246A("trials_loss", _id_C31C0E4113B9CD1E);
  _id_D2839A61FD7992F4 = ["mp_round_win_playlist"];
  _id_7AB5B649FA408138::_id_B11CFEE3350D246A("trials_win_low", _id_D2839A61FD7992F4);
  _id_E41DC0620B83075C = ["mp_round_win_playlist"];
  _id_7AB5B649FA408138::_id_B11CFEE3350D246A("trials_win_mid", _id_E41DC0620B83075C);
  _id_39F2EBE3966B362E = ["mp_round_win_playlist"];
  _id_7AB5B649FA408138::_id_B11CFEE3350D246A("trials_win_high", _id_39F2EBE3966B362E);
  _id_CACEB3FF609E8C65 = ["infected_01", "infected_02", "infected_03", "infected_04", "infected_05"];
  _id_7AB5B649FA408138::_id_B11CFEE3350D246A("infected", _id_CACEB3FF609E8C65);
  _id_FD8C34FA511407DF = ["mp_hp_new_playlist", "mp_hp_captured_playlist"];
  _id_7AB5B649FA408138::_id_B11CFEE3350D246A("ko_carry_music", _id_FD8C34FA511407DF);
  _id_C707AC6F8594811D = ["mp_prisoner_loop_1", "mp_prisoner_loop_2"];
  _id_7AB5B649FA408138::_id_B11CFEE3350D246A("prisoner_carry_music", _id_C707AC6F8594811D);
  _id_E9602E7CD3B7A190 = ["mx_mp_br_delta_zonecontrol_loop1", "mx_mp_br_delta_zonecontrol_loop2", "mx_mp_br_delta_zonecontrol_loop3"];
  _id_7AB5B649FA408138::_id_B11CFEE3350D246A("zc_zone_streak_main", _id_E9602E7CD3B7A190);

  if(level.gametype == "bigctf" || level.gametype == "havoc") {
    _id_F1BCFF5BB49B73D9 = ["mx_mp_ctf_timesup_win"];
    _id_7AB5B649FA408138::_id_B11CFEE3350D246A("winning_axis", _id_F1BCFF5BB49B73D9);
    _id_0B859892416A15F1 = ["mx_mp_ctf_timesup_lose"];
    _id_7AB5B649FA408138::_id_B11CFEE3350D246A("losing_axis", _id_0B859892416A15F1);
    _id_809968286B16012E = ["mx_mp_ctf_timesup_win"];
    _id_7AB5B649FA408138::_id_B11CFEE3350D246A("winning_allies", _id_809968286B16012E);
    _id_83EB6DB3E01FA1B6 = ["mx_mp_ctf_timesup_lose"];
    _id_7AB5B649FA408138::_id_B11CFEE3350D246A("losing_allies", _id_83EB6DB3E01FA1B6);
    _id_B41695C9593199E8 = ["mx_mp_ctf_infils"];
    _id_7AB5B649FA408138::_id_B11CFEE3350D246A("spawn_axis", _id_B41695C9593199E8);
    _id_39D6886350FA21AB = ["mx_mp_ctf_infils"];
    _id_7AB5B649FA408138::_id_B11CFEE3350D246A("spawn_allies", _id_39D6886350FA21AB);
    _id_967EC7E06AE0CA71 = ["mx_mp_ctf_infils"];
    _id_7AB5B649FA408138::_id_B11CFEE3350D246A("east_animated_infil", _id_967EC7E06AE0CA71);
    _id_B27BD19DDA4DB8D3 = ["mx_mp_ctf_infils"];
    _id_7AB5B649FA408138::_id_B11CFEE3350D246A("west_animated_infil", _id_B27BD19DDA4DB8D3);
  }

  if(level.gametype == "infect") {
    _id_B27BD19DDA4DB8D3 = ["mx_mp_br_zombieresurgence_circle_close_med_2", "mx_mp_br_zombieresurgence_circle_close_med_4", "mx_mp_br_zombieresurgence_circle_close_high_2"];
    _id_7AB5B649FA408138::_id_B11CFEE3350D246A("west_animated_infil", _id_B27BD19DDA4DB8D3);
    _id_C831B9C778E478ED = ["mx_mp_br_zombieresurgence_circle_close_med_2", "mx_mp_br_zombieresurgence_circle_close_med_4", "mx_mp_br_zombieresurgence_circle_close_high_2"];
    _id_7AB5B649FA408138::_id_B11CFEE3350D246A("east_animated_infil", _id_967EC7E06AE0CA71);
    _id_39D6886350FA21AB = ["mx_mp_br_zombieresurgence_circle_close_med_2", "mx_mp_br_zombieresurgence_circle_close_med_4", "mx_mp_br_zombieresurgence_circle_close_high_2"];
    _id_7AB5B649FA408138::_id_B11CFEE3350D246A("spawn_allies", _id_39D6886350FA21AB);
    _id_B41695C9593199E8 = ["mx_mp_br_zombieresurgence_circle_close_med_2", "mx_mp_br_zombieresurgence_circle_close_med_4", "mx_mp_br_zombieresurgence_circle_close_high_2"];
    _id_7AB5B649FA408138::_id_B11CFEE3350D246A("spawn_axis", _id_B41695C9593199E8);
  }

  _id_0A5E3FAC0C5201A8();
  _id_79D09D8DFF37FF80();
  _id_C85C8D480A1F8D97();
  _id_0350D33613FA93E9();
}

_id_0A5E3FAC0C5201A8() {
  _id_876B9BDA831CF678 = ["mx_mp_generic_suspense_1", "mx_mp_generic_suspense_2", "mx_mp_generic_suspense_3", "mx_mp_generic_suspense_4", "mx_mp_generic_suspense_5", "mx_mp_generic_suspense_6", "mx_mp_generic_suspense_7", "mx_mp_generic_suspense_8", "mx_mp_mexico_suspense_1", "mx_mp_mexico_suspense_2", "mx_mp_mexico_suspense_3", "mx_mp_mexico_suspense_4", "mx_mp_mexico_suspense_5", "mx_mp_mexico_suspense_6", "mx_mp_mexico_suspense_7", "mx_mp_mexico_suspense_8"];

  if(_id_7AB5B649FA408138::_id_5DF2F278F44A6FFD("middle_east")) {
    _id_7BB0F6F911721EBC = ["mx_mp_mideast_suspense_1", "mx_mp_mideast_suspense_2", "mx_mp_mideast_suspense_3", "mx_mp_mideast_suspense_4", "mx_mp_mideast_suspense_5", "mx_mp_mideast_suspense_6", "mx_mp_mideast_suspense_7", "mx_mp_mideast_suspense_8"];
    _id_876B9BDA831CF678 = scripts\engine\utility::array_combine(_id_876B9BDA831CF678, _id_7BB0F6F911721EBC);
  }

  _id_7AB5B649FA408138::_id_B11CFEE3350D246A("allies_suspense", _id_876B9BDA831CF678);
  _id_450BE247F3499473 = ["mx_mp_generic_suspense_1_classic", "mx_mp_generic_suspense_2_classic", "mx_mp_generic_suspense_3_classic", "mx_mp_generic_suspense_4_classic", "mx_mp_generic_suspense_5_classic", "mx_mp_generic_suspense_6_classic", "mx_mp_generic_suspense_7_classic", "mx_mp_generic_suspense_8_classic"];

  if(_id_7AB5B649FA408138::_id_5DF2F278F44A6FFD("middle_east")) {
    _id_117A27F685AD48C7 = ["mx_mp_mideast_suspense_1_classic", "mx_mp_mideast_suspense_2_classic", "mx_mp_mideast_suspense_3_classic", "mx_mp_mideast_suspense_4_classic", "mx_mp_mideast_suspense_5_classic", "mx_mp_mideast_suspense_6_classic", "mx_mp_mideast_suspense_7_classic", "mx_mp_mideast_suspense_8_classic"];
    _id_450BE247F3499473 = scripts\engine\utility::array_combine(_id_450BE247F3499473, _id_117A27F685AD48C7);
  }

  if(_id_7AB5B649FA408138::_id_5DF2F278F44A6FFD("mexico")) {
    _id_BA852636D22AEECD = ["mx_mp_mexico_suspense_1_classic", "mx_mp_mexico_suspense_2_classic", "mx_mp_mexico_suspense_3_classic", "mx_mp_mexico_suspense_4_classic", "mx_mp_mexico_suspense_5_classic", "mx_mp_mexico_suspense_6_classic", "mx_mp_mexico_suspense_7_classic", "mx_mp_mexico_suspense_8_classic"];
    _id_450BE247F3499473 = scripts\engine\utility::array_combine(_id_450BE247F3499473, _id_BA852636D22AEECD);
  }

  _id_7AB5B649FA408138::_id_B11CFEE3350D246A("allies_suspense_classic", _id_450BE247F3499473);
  _id_560A737B7CD500DD = ["mx_mp_generic_suspense_1", "mx_mp_generic_suspense_2", "mx_mp_generic_suspense_3", "mx_mp_generic_suspense_4", "mx_mp_generic_suspense_5", "mx_mp_generic_suspense_6", "mx_mp_generic_suspense_7", "mx_mp_generic_suspense_8", "mx_mp_mexico_suspense_1", "mx_mp_mexico_suspense_2", "mx_mp_mexico_suspense_3", "mx_mp_mexico_suspense_4", "mx_mp_mexico_suspense_5", "mx_mp_mexico_suspense_6", "mx_mp_mexico_suspense_7", "mx_mp_mexico_suspense_8"];

  if(_id_7AB5B649FA408138::_id_5DF2F278F44A6FFD("middle_east")) {
    _id_8CBC4DE0FF7369F1 = ["mx_mp_mideast_suspense_1", "mx_mp_mideast_suspense_2", "mx_mp_mideast_suspense_3", "mx_mp_mideast_suspense_4", "mx_mp_mideast_suspense_5", "mx_mp_mideast_suspense_6", "mx_mp_mideast_suspense_7", "mx_mp_mideast_suspense_8"];
    _id_560A737B7CD500DD = scripts\engine\utility::array_combine(_id_560A737B7CD500DD, _id_8CBC4DE0FF7369F1);
  }

  _id_7AB5B649FA408138::_id_B11CFEE3350D246A("axis_suspense", _id_560A737B7CD500DD);
  _id_10A05DFCF8344F3A = ["mx_mp_generic_suspense_1_classic", "mx_mp_generic_suspense_2_classic", "mx_mp_generic_suspense_3_classic", "mx_mp_generic_suspense_4_classic", "mx_mp_generic_suspense_5_classic", "mx_mp_generic_suspense_6_classic", "mx_mp_generic_suspense_7_classic", "mx_mp_generic_suspense_8_classic"];

  if(_id_7AB5B649FA408138::_id_5DF2F278F44A6FFD("middle_east")) {
    _id_688A88378FF6AB1E = ["mx_mp_mideast_suspense_1_classic", "mx_mp_mideast_suspense_2_classic", "mx_mp_mideast_suspense_3_classic", "mx_mp_mideast_suspense_4_classic", "mx_mp_mideast_suspense_5_classic", "mx_mp_mideast_suspense_6_classic", "mx_mp_mideast_suspense_7_classic", "mx_mp_mideast_suspense_8_classic"];
    _id_10A05DFCF8344F3A = scripts\engine\utility::array_combine(_id_10A05DFCF8344F3A, _id_688A88378FF6AB1E);
  }

  if(_id_7AB5B649FA408138::_id_5DF2F278F44A6FFD("mexico")) {
    _id_AC960A84746D1E6E = ["mx_mp_mexico_suspense_1_classic", "mx_mp_mexico_suspense_2_classic", "mx_mp_mexico_suspense_3_classic", "mx_mp_mexico_suspense_4_classic", "mx_mp_mexico_suspense_5_classic", "mx_mp_mexico_suspense_6_classic", "mx_mp_mexico_suspense_7_classic", "mx_mp_mexico_suspense_8_classic"];
    _id_10A05DFCF8344F3A = scripts\engine\utility::array_combine(_id_10A05DFCF8344F3A, _id_AC960A84746D1E6E);
  }

  _id_7AB5B649FA408138::_id_B11CFEE3350D246A("axis_suspense_classic", _id_10A05DFCF8344F3A);
}

_id_79D09D8DFF37FF80() {
  _id_FDD4CB56C3B978A3 = scripts\cp_mp\utility\game_utility::_id_0BEFF479639E6508();

  if(!istrue(_id_FDD4CB56C3B978A3)) {
    return;
  }
  _id_A0BD6B17E1037F3B = ["mx_mp_br_prelobby_intro"];
  _id_7AB5B649FA408138::_id_B11CFEE3350D246A("br_lobby_intro", _id_A0BD6B17E1037F3B);
  _id_3C143D48494EBF12 = ["mx_mp_br_prelobby_outro"];
  _id_7AB5B649FA408138::_id_B11CFEE3350D246A("br_lobby_outro", _id_3C143D48494EBF12);
  _id_D788FBB04A7A099D = ["mx_mp_br_infil_1"];
  _id_7AB5B649FA408138::_id_B11CFEE3350D246A("br_infil_intro", _id_D788FBB04A7A099D);
  _id_B97178D3FFC0AEE1 = ["mx_mp_br_infil_parachute_1", "mx_mp_br_infil_parachute_2", "mx_mp_br_infil_parachute_3", "mx_mp_br_infil_parachute_4"];
  _id_7AB5B649FA408138::_id_B11CFEE3350D246A("br_plane_jump", _id_B97178D3FFC0AEE1);
  _id_FBA2E07D75159AE9 = [""];
  _id_7AB5B649FA408138::_id_B11CFEE3350D246A("br_plane_jump_parachute", _id_FBA2E07D75159AE9);
  _id_3437F7BDB4F9DE0F = ["mx_mp_br_gulag_intro_1", "mx_mp_br_gulag_intro_2", "mx_mp_br_gulag_intro_3"];
  _id_7AB5B649FA408138::_id_B11CFEE3350D246A("br_gulag_intro", _id_3437F7BDB4F9DE0F);
  _id_35EE2C0159889858 = ["mx_mp_br_gulag_juggernaut"];
  _id_7AB5B649FA408138::_id_B11CFEE3350D246A("br_gulag_jailer", _id_35EE2C0159889858);
  _id_1146C25A252F6B0E = ["mx_mp_br_gulag_lose"];
  _id_7AB5B649FA408138::_id_B11CFEE3350D246A("br_gulag_lose", _id_1146C25A252F6B0E);
  _id_4A043CC9593EA633 = ["mx_mp_br_gulag_win"];
  _id_7AB5B649FA408138::_id_B11CFEE3350D246A("br_gulag_win", _id_4A043CC9593EA633);
  _id_9C833A588CDEA389 = ["mx_mp_br_circle_close_low_1", "mx_mp_br_circle_close_low_2", "mx_mp_br_circle_close_low_3", "mx_mp_br_circle_close_low_4", "mx_mp_br_circle_close_low_5", "mx_mp_br_circle_close_low_6", "mx_mp_br_circle_close_low_7", "mx_mp_br_circle_close_low_8", "mx_mp_br_circle_close_low_9", "mx_mp_br_circle_close_low_10"];
  _id_7AB5B649FA408138::_id_B11CFEE3350D246A("br_ring_low", _id_9C833A588CDEA389);
  _id_8BBC14587FBD1071 = ["mx_mp_br_circle_close_med_1", "mx_mp_br_circle_close_med_2", "mx_mp_br_circle_close_med_3", "mx_mp_br_circle_close_med_4", "mx_mp_br_circle_close_med_5", "mx_mp_br_circle_close_med_6", "mx_mp_br_circle_close_med_7", "mx_mp_br_circle_close_med_8", "mx_mp_br_circle_close_med_9", "mx_mp_br_circle_close_med_10"];
  _id_7AB5B649FA408138::_id_B11CFEE3350D246A("br_ring_med", _id_8BBC14587FBD1071);
  _id_FC6034154E353165 = ["mx_mp_br_circle_close_high_1", "mx_mp_br_circle_close_high_2", "mx_mp_br_circle_close_high_3", "mx_mp_br_circle_close_high_4", "mx_mp_br_circle_close_high_5", "mx_mp_br_circle_close_high_6", "mx_mp_br_circle_close_high_7", "mx_mp_br_circle_close_high_8", "mx_mp_br_circle_close_high_9", "mx_mp_br_circle_close_high_10"];
  _id_7AB5B649FA408138::_id_B11CFEE3350D246A("br_ring_high", _id_FC6034154E353165);
  _id_3D687AABF72E4E2F = ["mx_mp_br_circle_close_final_loop_1", "mx_mp_br_circle_close_final_loop_2", "mx_mp_br_circle_close_final_loop_3", "mx_mp_br_circle_close_final_loop_4", "mx_mp_br_circle_close_final_loop_5", "mx_mp_br_circle_close_final_loop_6", "mx_mp_br_circle_close_final_loop_7", "mx_mp_br_circle_close_final_loop_8"];
  _id_7AB5B649FA408138::_id_B11CFEE3350D246A("br_ring_final", _id_3D687AABF72E4E2F);
  _id_0A98588E08A2CF6A = ["mx_mp_br_exfil1"];
  _id_7AB5B649FA408138::_id_B11CFEE3350D246A("br_exfil_intro1", _id_0A98588E08A2CF6A);
  _id_0A98578E08A2CD37 = ["mx_mp_br_exfil2"];
  _id_7AB5B649FA408138::_id_B11CFEE3350D246A("br_exfil_intro2", _id_0A98578E08A2CD37);
  _id_0A98568E08A2CB04 = ["mx_mp_br_exfil3"];
  _id_7AB5B649FA408138::_id_B11CFEE3350D246A("br_exfil_intro3", _id_0A98568E08A2CB04);
  _id_0A98558E08A2C8D1 = ["mx_mp_br_exfil4"];
  _id_7AB5B649FA408138::_id_B11CFEE3350D246A("br_exfil_intro4", _id_0A98558E08A2C8D1);
  _id_0A98548E08A2C69E = ["mx_mp_br_exfil5"];
  _id_7AB5B649FA408138::_id_B11CFEE3350D246A("br_exfil_intro5", _id_0A98548E08A2C69E);
  _id_0A98538E08A2C46B = ["mx_mp_br_exfil6"];
  _id_7AB5B649FA408138::_id_B11CFEE3350D246A("br_exfil_intro6", _id_0A98538E08A2C46B);
  _id_0A98528E08A2C238 = ["mx_mp_br_exfil7"];
  _id_7AB5B649FA408138::_id_B11CFEE3350D246A("br_exfil_intro7", _id_0A98528E08A2C238);

  if(scripts\mp\utility\game::getsubgametype() == "zxp") {
    _id_D788FBB04A7A099D = ["mx_mp_br_zombieresurgence_infil"];
    _id_7AB5B649FA408138::_id_B11CFEE3350D246A("br_infil_intro", _id_D788FBB04A7A099D);
    _id_0A98588E08A2CF6A = ["mx_mp_br_zombieresurgence_exfil1"];
    _id_7AB5B649FA408138::_id_B11CFEE3350D246A("br_exfil_intro1", _id_0A98588E08A2CF6A);
    _id_0A98578E08A2CD37 = ["mx_mp_br_zombieresurgence_exfil2"];
    _id_7AB5B649FA408138::_id_B11CFEE3350D246A("br_exfil_intro2", _id_0A98578E08A2CD37);
    _id_0A98568E08A2CB04 = ["mx_mp_br_zombieresurgence_exfil3"];
    _id_7AB5B649FA408138::_id_B11CFEE3350D246A("br_exfil_intro3", _id_0A98568E08A2CB04);
    _id_0A98558E08A2C8D1 = ["mx_mp_br_zombieresurgence_exfil4"];
    _id_7AB5B649FA408138::_id_B11CFEE3350D246A("br_exfil_intro4", _id_0A98558E08A2C8D1);
    _id_0A98548E08A2C69E = ["mx_mp_br_zombieresurgence_exfil5"];
    _id_7AB5B649FA408138::_id_B11CFEE3350D246A("br_exfil_intro5", _id_0A98548E08A2C69E);
    _id_0A98538E08A2C46B = ["mx_mp_br_zombieresurgence_exfil6"];
    _id_7AB5B649FA408138::_id_B11CFEE3350D246A("br_exfil_intro6", _id_0A98538E08A2C46B);
    _id_0A98528E08A2C238 = ["mx_mp_br_zombieresurgence_exfil6"];
    _id_7AB5B649FA408138::_id_B11CFEE3350D246A("br_exfil_intro7", _id_0A98528E08A2C238);
    _id_9C833A588CDEA389 = ["mx_mp_br_zombieresurgence_circle_close_low_1", "mx_mp_br_zombieresurgence_circle_close_low_2", "mx_mp_br_zombieresurgence_circle_close_low_3", "mx_mp_br_zombieresurgence_circle_close_low_4"];
    _id_7AB5B649FA408138::_id_B11CFEE3350D246A("br_ring_low", _id_9C833A588CDEA389);
    _id_8BBC14587FBD1071 = ["mx_mp_br_zombieresurgence_circle_close_med_1", "mx_mp_br_zombieresurgence_circle_close_med_2", "mx_mp_br_zombieresurgence_circle_close_med_3", "mx_mp_br_zombieresurgence_circle_close_med_4"];
    _id_7AB5B649FA408138::_id_B11CFEE3350D246A("br_ring_med", _id_8BBC14587FBD1071);
    _id_FC6034154E353165 = ["mx_mp_br_zombieresurgence_circle_close_high_1", "mx_mp_br_zombieresurgence_circle_close_high_2"];
    _id_7AB5B649FA408138::_id_B11CFEE3350D246A("br_ring_high", _id_FC6034154E353165);
    _id_3D687AABF72E4E2F = ["mx_mp_br_zombieresurgence_circle_close_final_1"];
    _id_7AB5B649FA408138::_id_B11CFEE3350D246A("br_ring_final", _id_3D687AABF72E4E2F);
  }

  _id_D5B74FD05CE437E0 = ["mx_mp_br_elitecontracts_elementfound_1", "mx_mp_br_elitecontracts_elementfound_2", "mx_mp_br_elitecontracts_elementfound_3", "mx_mp_br_elitecontracts_elementfound_4", "mx_mp_br_elitecontracts_elementfound_5", "mx_mp_br_elitecontracts_elementfound_6", "mx_mp_br_elitecontracts_elementfound_7", "mx_mp_br_elitecontracts_elementfound_8", "mx_mp_br_elitecontracts_elementfound_9", "mx_mp_br_elitecontracts_elementfound_10", "mx_mp_br_elitecontracts_elementfound_11", "mx_mp_br_elitecontracts_elementfound_12"];
  _id_7AB5B649FA408138::_id_B11CFEE3350D246A("br_elite_arrow_element", _id_D5B74FD05CE437E0);
  _id_1933AEF6359F408C = ["mx_mp_br_elitecontracts_bombarmed_1", "mx_mp_br_elitecontracts_bombarmed_2", "mx_mp_br_elitecontracts_bombarmed_3", "mx_mp_br_elitecontracts_bombarmed_4", "mx_mp_br_elitecontracts_bombarmed_5"];
  _id_7AB5B649FA408138::_id_B11CFEE3350D246A("br_elite_arrow_bomb_armed", _id_1933AEF6359F408C);

  if(scripts\cp_mp\utility\game_utility::_id_6C1FCE6F6B8779D5() == "truckwar") {
    _id_9C833A588CDEA389 = ["mx_mp_br_circle_truckwars_close_low"];
    _id_7AB5B649FA408138::_id_B11CFEE3350D246A("br_ring_low", _id_9C833A588CDEA389);
    _id_8BBC14587FBD1071 = ["mx_mp_br_circle_truckwars_close_med"];
    _id_7AB5B649FA408138::_id_B11CFEE3350D246A("br_ring_med", _id_8BBC14587FBD1071);
    _id_FC6034154E353165 = ["mx_mp_br_circle_truckwars_close_high"];
    _id_7AB5B649FA408138::_id_B11CFEE3350D246A("br_ring_high", _id_FC6034154E353165);
    _id_3D687AABF72E4E2F = ["mx_mp_br_circle_truckwars_close_final_loop_1"];
    _id_7AB5B649FA408138::_id_B11CFEE3350D246A("br_ring_final", _id_3D687AABF72E4E2F);
  }

  if(level.mapname == "mp_sealion") {
    _id_A0BD6B17E1037F3B = [""];
    _id_7AB5B649FA408138::_id_B11CFEE3350D246A("br_lobby_intro", _id_A0BD6B17E1037F3B);
    _id_3C143D48494EBF12 = ["mx_mp_br_infilcountdown"];
    _id_7AB5B649FA408138::_id_B11CFEE3350D246A("br_lobby_outro", _id_3C143D48494EBF12);
    _id_D788FBB04A7A099D = ["mx_mp_br_s2_infil"];
    _id_7AB5B649FA408138::_id_B11CFEE3350D246A("br_infil_intro", _id_D788FBB04A7A099D);
    _id_B97178D3FFC0AEE1 = [""];
    _id_7AB5B649FA408138::_id_B11CFEE3350D246A("br_plane_jump", _id_B97178D3FFC0AEE1);
    _id_FBA2E07D75159AE9 = [""];
    _id_7AB5B649FA408138::_id_B11CFEE3350D246A("br_plane_jump_parachute", _id_FBA2E07D75159AE9);
    _id_9C833A588CDEA389 = ["mx_mp_br_s2_circle_close_low"];
    _id_7AB5B649FA408138::_id_B11CFEE3350D246A("br_ring_low", _id_9C833A588CDEA389);
    _id_8BBC14587FBD1071 = ["mx_mp_br_s2_circle_close_med"];
    _id_7AB5B649FA408138::_id_B11CFEE3350D246A("br_ring_med", _id_8BBC14587FBD1071);
    _id_FC6034154E353165 = ["mx_mp_br_s2_circle_close_high"];
    _id_7AB5B649FA408138::_id_B11CFEE3350D246A("br_ring_high", _id_FC6034154E353165);
    _id_3D687AABF72E4E2F = ["mx_mp_br_s2_circle_close_final_loop_1", "mx_mp_br_s2_circle_close_final_loop_2"];
    _id_7AB5B649FA408138::_id_B11CFEE3350D246A("br_ring_final", _id_3D687AABF72E4E2F);
  }

  if(scripts\cp_mp\utility\game_utility::_id_FA7BFCC1D68B7B73()) {
    _id_A0BD6B17E1037F3B = ["mx_mp_br_prelobby_intro"];
    _id_7AB5B649FA408138::_id_B11CFEE3350D246A("br_lobby_intro", _id_A0BD6B17E1037F3B);
    _id_3C143D48494EBF12 = ["mx_mp_br_prelobby_outro"];
    _id_7AB5B649FA408138::_id_B11CFEE3350D246A("br_lobby_outro", _id_3C143D48494EBF12);
    _id_D788FBB04A7A099D = ["mx_mp_br_infil_1"];
    _id_7AB5B649FA408138::_id_B11CFEE3350D246A("br_infil_intro", _id_D788FBB04A7A099D);
    _id_B97178D3FFC0AEE1 = ["mx_mp_br_infil_parachute_1", "mx_mp_br_infil_parachute_2", "mx_mp_br_infil_parachute_3", "mx_mp_br_infil_parachute_4"];
    _id_7AB5B649FA408138::_id_B11CFEE3350D246A("br_plane_jump", _id_B97178D3FFC0AEE1);
    _id_FBA2E07D75159AE9 = [""];
    _id_7AB5B649FA408138::_id_B11CFEE3350D246A("br_plane_jump_parachute", _id_FBA2E07D75159AE9);
    _id_3437F7BDB4F9DE0F = ["mx_mp_br_gulag_intro_1", "mx_mp_br_gulag_intro_2", "mx_mp_br_gulag_intro_3"];
    _id_7AB5B649FA408138::_id_B11CFEE3350D246A("br_gulag_intro", _id_3437F7BDB4F9DE0F);
    _id_35EE2C0159889858 = ["mx_mp_br_gulag_juggernaut"];
    _id_7AB5B649FA408138::_id_B11CFEE3350D246A("br_gulag_jailer", _id_35EE2C0159889858);
    _id_1146C25A252F6B0E = ["mx_mp_br_gulag_lose"];
    _id_7AB5B649FA408138::_id_B11CFEE3350D246A("br_gulag_lose", _id_1146C25A252F6B0E);
    _id_4A043CC9593EA633 = ["mx_mp_br_gulag_win"];
    _id_7AB5B649FA408138::_id_B11CFEE3350D246A("br_gulag_win", _id_4A043CC9593EA633);
    _id_9C833A588CDEA389 = ["mx_mp_br_circle_close_low_1", "mx_mp_br_circle_close_low_2", "mx_mp_br_circle_close_low_3"];
    _id_7AB5B649FA408138::_id_B11CFEE3350D246A("br_ring_low", _id_9C833A588CDEA389);
    _id_8BBC14587FBD1071 = ["mx_mp_br_circle_close_med_1", "mx_mp_br_circle_close_med_2", "mx_mp_br_circle_close_med_3"];
    _id_7AB5B649FA408138::_id_B11CFEE3350D246A("br_ring_med", _id_8BBC14587FBD1071);
    _id_FC6034154E353165 = ["mx_mp_br_circle_close_high_1", "mx_mp_br_circle_close_high_2", "mx_mp_br_circle_close_high_3"];
    _id_7AB5B649FA408138::_id_B11CFEE3350D246A("br_ring_high", _id_FC6034154E353165);
    _id_3D687AABF72E4E2F = ["mx_mp_br_circle_close_final_loop_1", "mx_mp_br_circle_close_final_loop_2", "mx_mp_br_circle_close_final_loop_3"];
    _id_7AB5B649FA408138::_id_B11CFEE3350D246A("br_ring_final", _id_3D687AABF72E4E2F);
    _id_0A98588E08A2CF6A = ["mx_mp_br_exfil1"];
    _id_7AB5B649FA408138::_id_B11CFEE3350D246A("br_exfil_intro1", _id_0A98588E08A2CF6A);
    _id_0A98578E08A2CD37 = ["mx_mp_br_exfil2"];
    _id_7AB5B649FA408138::_id_B11CFEE3350D246A("br_exfil_intro2", _id_0A98578E08A2CD37);
    _id_0A98568E08A2CB04 = ["mx_mp_br_exfil3"];
    _id_7AB5B649FA408138::_id_B11CFEE3350D246A("br_exfil_intro3", _id_0A98568E08A2CB04);
    _id_0A98558E08A2C8D1 = ["mx_mp_br_exfil4"];
    _id_7AB5B649FA408138::_id_B11CFEE3350D246A("br_exfil_intro4", _id_0A98558E08A2C8D1);
    _id_0A98548E08A2C69E = ["mx_mp_br_exfil5"];
    _id_7AB5B649FA408138::_id_B11CFEE3350D246A("br_exfil_intro5", _id_0A98548E08A2C69E);
    _id_0A98538E08A2C46B = ["mx_mp_br_exfil6"];
    _id_7AB5B649FA408138::_id_B11CFEE3350D246A("br_exfil_intro6", _id_0A98538E08A2C46B);
    _id_0A98528E08A2C238 = ["mx_mp_br_exfil7"];
    _id_7AB5B649FA408138::_id_B11CFEE3350D246A("br_exfil_intro7", _id_0A98528E08A2C238);
  }
}

_id_C85C8D480A1F8D97() {
  _id_6A1D06B01F51312E = scripts\cp_mp\utility\game_utility::_id_6C1FCE6F6B8779D5() == "dmz";

  if(!istrue(_id_6A1D06B01F51312E)) {
    return;
  }
  _id_454118824CC58D59 = ["iw9_mp_dmz_infil1", "iw9_mp_dmz_infil2", "iw9_mp_dmz_infil3", "iw9_mp_dmz_infil4", "iw9_mp_dmz_infil5"];
  _id_7AB5B649FA408138::_id_B11CFEE3350D246A("dmz_infil", _id_454118824CC58D59);
  _id_D63C781D5E272B07 = ["iw9_mp_dmz_activity_start"];
  _id_7AB5B649FA408138::_id_B11CFEE3350D246A("dmz_activity_start", _id_D63C781D5E272B07);
  _id_DCEA6768454F7075 = ["iw9_mp_dmz_activity_tension"];
  _id_7AB5B649FA408138::_id_B11CFEE3350D246A("dmz_activity_tension", _id_DCEA6768454F7075);
  _id_A6A9A86B34886947 = ["iw9_mp_dmz_activity_action"];
  _id_7AB5B649FA408138::_id_B11CFEE3350D246A("dmz_activity_action", _id_A6A9A86B34886947);
  _id_F139A00330157E01 = ["iw9_mp_dmz_activity_won"];
  _id_7AB5B649FA408138::_id_B11CFEE3350D246A("dmz_activity_win", _id_F139A00330157E01);
  _id_4FE255A72526EA50 = ["iw9_mp_dmz_activity_lose"];
  _id_7AB5B649FA408138::_id_B11CFEE3350D246A("dmz_activity_lose", _id_4FE255A72526EA50);
  _id_E88759CB86FDD100 = ["iw9_mp_dmz_exfil1", "iw9_mp_dmz_exfil2"];
  _id_7AB5B649FA408138::_id_B11CFEE3350D246A("dmz_exfil_start", _id_E88759CB86FDD100);
  _id_2819E2439ACC1EBA = ["iw9_mp_dmz_exfil_manual"];
  _id_7AB5B649FA408138::_id_B11CFEE3350D246A("dmz_exfil_manual", _id_2819E2439ACC1EBA);
  _id_18A2F15BD703A2A1 = [""];
  _id_7AB5B649FA408138::_id_B11CFEE3350D246A("dmz_exfil_end", _id_18A2F15BD703A2A1);
  _id_4DA264F376886BE6 = ["iw9_mp_dmz_exfil_abort"];
  _id_7AB5B649FA408138::_id_B11CFEE3350D246A("dmz_exfil_abort", _id_4DA264F376886BE6);

  if(_id_2C3C990BA58FA6F5::_id_D3915632A8C61EB2()) {
    _id_454118824CC58D59 = ["mx_mp_dmz_halloween_infil_1", "mx_mp_dmz_halloween_infil_2", "mx_mp_dmz_halloween_infil_3"];
    _id_7AB5B649FA408138::_id_B11CFEE3350D246A("dmz_infil", _id_454118824CC58D59);
    _id_E88759CB86FDD100 = ["mx_mp_dmz_halloween_exfil_1", "mx_mp_dmz_halloween_exfil_2"];
    _id_7AB5B649FA408138::_id_B11CFEE3350D246A("dmz_exfil_start", _id_E88759CB86FDD100);
  }

  _id_C7A65D3179814CC4 = ["dmz_stronghold_unlock"];
  _id_7AB5B649FA408138::_id_B11CFEE3350D246A("dmz_stronghold_unlock", _id_C7A65D3179814CC4);
  _id_7E080BBFC46B8CA9 = ["dmz_elimination_accept"];
  _id_7AB5B649FA408138::_id_B11CFEE3350D246A("dmz_elimination_start", _id_7E080BBFC46B8CA9);
  _id_B6E7190F76EAFFA3 = ["dmz_elimination_approach"];
  _id_7AB5B649FA408138::_id_B11CFEE3350D246A("dmz_elimination_approach", _id_B6E7190F76EAFFA3);
  _id_1B55C8D86242310B = ["dmz_elimination_kill"];
  _id_7AB5B649FA408138::_id_B11CFEE3350D246A("dmz_elimination_win", _id_1B55C8D86242310B);
  _id_DA35141B9FC37A14 = ["dmz_geigersearch_pickups"];
  _id_7AB5B649FA408138::_id_B11CFEE3350D246A("dmz_geigersearch_pickups", _id_DA35141B9FC37A14);
  _id_D29CB1BF83061CF5 = ["dmz_fortress_hostage_contract"];
  _id_7AB5B649FA408138::_id_B11CFEE3350D246A("dmz_hostage_start", _id_D29CB1BF83061CF5);
  _id_D8D6495453ACAB6F = ["dmz_fortress_hostage_approach"];
  _id_7AB5B649FA408138::_id_B11CFEE3350D246A("dmz_hostage_approach", _id_D8D6495453ACAB6F);
  _id_6119A9E44619FB46 = ["dmz_stronghold_unlock"];
  _id_7AB5B649FA408138::_id_B11CFEE3350D246A("dmz_hostage_breach", _id_6119A9E44619FB46);
  _id_BBDB7AF5D94697A2 = ["dmz_fortress_hostage_rescue"];
  _id_7AB5B649FA408138::_id_B11CFEE3350D246A("dmz_hostage_rescue", _id_BBDB7AF5D94697A2);
  _id_BEC4DD4BF1178292 = ["dmz_fortress_hostage_rescuefailed"];
  _id_7AB5B649FA408138::_id_B11CFEE3350D246A("dmz_hostage_rescue_failed", _id_BEC4DD4BF1178292);
  _id_EBB76EDE80479709 = ["dmz_trap_assigned"];
  _id_7AB5B649FA408138::_id_B11CFEE3350D246A("dmz_trap_start", _id_EBB76EDE80479709);
  _id_BDE0656CB5A15883 = ["dmz_trap_approach"];
  _id_7AB5B649FA408138::_id_B11CFEE3350D246A("dmz_trap_approach", _id_BDE0656CB5A15883);
  _id_F123EF4D152BFE74 = ["dmz_trap_drill"];
  _id_7AB5B649FA408138::_id_B11CFEE3350D246A("dmz_trap_drill", _id_F123EF4D152BFE74);
  _id_C45C39E95D079D1D = ["mx_mp_dmz_safecracker_train_loop"];
  _id_7AB5B649FA408138::_id_B11CFEE3350D246A("dmz_train_safe_drill", _id_C45C39E95D079D1D);

  if(level.mapname == "mp_bio_lab" || level.mapname == "mp_biobunker") {
    _id_454118824CC58D59 = ["dmz_stronghold_unlock"];
    _id_7AB5B649FA408138::_id_B11CFEE3350D246A("dmz_infil", _id_454118824CC58D59);
  }

  if(level.mapname == "mp_sealion") {
    _id_D63C781D5E272B07 = ["mx_mp_dmz_s2_activity_start"];
    _id_7AB5B649FA408138::_id_B11CFEE3350D246A("dmz_activity_start", _id_D63C781D5E272B07);
    _id_DCEA6768454F7075 = ["mx_mp_dmz_s2_activity_tension"];
    _id_7AB5B649FA408138::_id_B11CFEE3350D246A("dmz_activity_tension", _id_DCEA6768454F7075);
    _id_A6A9A86B34886947 = ["mx_mp_dmz_s2_activity_action"];
    _id_7AB5B649FA408138::_id_B11CFEE3350D246A("dmz_activity_action", _id_A6A9A86B34886947);
    _id_F139A00330157E01 = ["mx_mp_dmz_s2_activity_win"];
    _id_7AB5B649FA408138::_id_B11CFEE3350D246A("dmz_activity_win", _id_F139A00330157E01);
    _id_4FE255A72526EA50 = ["mx_mp_dmz_s2_activity_lose"];
    _id_7AB5B649FA408138::_id_B11CFEE3350D246A("dmz_activity_lose", _id_4FE255A72526EA50);
    _id_E88759CB86FDD100 = ["mx_mp_dmz_s2_exfil1", "mx_mp_dmz_s2_exfil2"];
    _id_7AB5B649FA408138::_id_B11CFEE3350D246A("dmz_exfil_start", _id_E88759CB86FDD100);
    _id_C7A65D3179814CC4 = ["dmz_stronghold_unlock"];
    _id_7AB5B649FA408138::_id_B11CFEE3350D246A("dmz_stronghold_unlock", _id_C7A65D3179814CC4);
    _id_7E080BBFC46B8CA9 = ["mx_mp_dmz_s2_activity_start"];
    _id_7AB5B649FA408138::_id_B11CFEE3350D246A("dmz_elimination_start", _id_D63C781D5E272B07);
    _id_B6E7190F76EAFFA3 = ["mx_mp_dmz_s2_activity_action_loop2"];
    _id_7AB5B649FA408138::_id_B11CFEE3350D246A("dmz_elimination_approach", _id_B6E7190F76EAFFA3);
    _id_1B55C8D86242310B = [""];
    _id_7AB5B649FA408138::_id_B11CFEE3350D246A("dmz_elimination_win", _id_1B55C8D86242310B);
    _id_DA35141B9FC37A14 = ["mx_mp_dmz_s2_activity_pickups"];
    _id_7AB5B649FA408138::_id_B11CFEE3350D246A("dmz_geigersearch_pickups", _id_DA35141B9FC37A14);
    _id_D29CB1BF83061CF5 = ["mx_mp_dmz_s2_activity_start"];
    _id_7AB5B649FA408138::_id_B11CFEE3350D246A("dmz_hostage_start", _id_D29CB1BF83061CF5);
    _id_D8D6495453ACAB6F = ["mx_mp_dmz_s2_activity_tension"];
    _id_7AB5B649FA408138::_id_B11CFEE3350D246A("dmz_hostage_approach", _id_D8D6495453ACAB6F);
    _id_6119A9E44619FB46 = ["dmz_stronghold_unlock"];
    _id_7AB5B649FA408138::_id_B11CFEE3350D246A("dmz_hostage_breach", _id_6119A9E44619FB46);
    _id_BBDB7AF5D94697A2 = ["mx_mp_dmz_s2_activity_action_loop3"];
    _id_7AB5B649FA408138::_id_B11CFEE3350D246A("dmz_hostage_rescue", _id_BBDB7AF5D94697A2);
    _id_BEC4DD4BF1178292 = ["mx_mp_dmz_s2_activity_lose"];
    _id_7AB5B649FA408138::_id_B11CFEE3350D246A("dmz_hostage_rescue_failed", _id_BEC4DD4BF1178292);
    _id_EBB76EDE80479709 = ["mx_mp_dmz_s2_activity_start"];
    _id_7AB5B649FA408138::_id_B11CFEE3350D246A("dmz_trap_start", _id_EBB76EDE80479709);
    _id_BDE0656CB5A15883 = ["mx_mp_dmz_s2_activity_tension"];
    _id_7AB5B649FA408138::_id_B11CFEE3350D246A("dmz_trap_approach", _id_BDE0656CB5A15883);
    _id_F123EF4D152BFE74 = ["mx_mp_dmz_s2_activity_action_loop2"];
    _id_7AB5B649FA408138::_id_B11CFEE3350D246A("dmz_trap_drill", _id_F123EF4D152BFE74);
  }
}

_id_F341FA4829572739() {
  _id_A0BD6B17E1037F3B = ["zxp_lobby_intro_01"];
  _id_7AB5B649FA408138::_id_B11CFEE3350D246A("br_lobby_intro", _id_A0BD6B17E1037F3B);
  _id_3C143D48494EBF12 = ["zxp_lobby_outro_01"];
  _id_7AB5B649FA408138::_id_B11CFEE3350D246A("br_lobby_outro", _id_3C143D48494EBF12);
  _id_D788FBB04A7A099D = ["zxp_infil_intro_01"];
  _id_7AB5B649FA408138::_id_B11CFEE3350D246A("br_infil_intro", _id_D788FBB04A7A099D);
  _id_B97178D3FFC0AEE1 = ["zxp_lobby_intro_01", "zxp_lobby_intro_02"];
  _id_7AB5B649FA408138::_id_B11CFEE3350D246A("br_plane_jump", _id_B97178D3FFC0AEE1);
  _id_E40AA798FAC3C4DF = ["zxp_ghost_spawn_01", "zxp_ghost_spawn_02"];
  _id_7AB5B649FA408138::_id_B11CFEE3350D246A("br_zmb_spawn", _id_E40AA798FAC3C4DF);
  _id_FBA2E07D75159AE9 = [""];
  _id_7AB5B649FA408138::_id_B11CFEE3350D246A("br_plane_jump_parachute", _id_FBA2E07D75159AE9);
  _id_3437F7BDB4F9DE0F = ["mx_mp_br_gulag_intro_1", "mx_mp_br_gulag_intro_2", "mx_mp_br_gulag_intro_3"];
  _id_7AB5B649FA408138::_id_B11CFEE3350D246A("br_gulag_intro", _id_3437F7BDB4F9DE0F);
  _id_1146C25A252F6B0E = ["mx_mp_br_gulag_lose"];
  _id_7AB5B649FA408138::_id_B11CFEE3350D246A("br_gulag_lose", _id_1146C25A252F6B0E);
  _id_4A043CC9593EA633 = ["mx_mp_br_gulag_win"];
  _id_7AB5B649FA408138::_id_B11CFEE3350D246A("br_gulag_win", _id_4A043CC9593EA633);
  _id_9C833A588CDEA389 = ["zxp_ring_low_01", "zxp_ring_low_02", "zxp_ring_low_03"];
  _id_7AB5B649FA408138::_id_B11CFEE3350D246A("br_ring_low", _id_9C833A588CDEA389);
  _id_8BBC14587FBD1071 = ["zxp_ring_med_01", "zxp_ring_med_02", "zxp_ring_med_03"];
  _id_7AB5B649FA408138::_id_B11CFEE3350D246A("br_ring_med", _id_8BBC14587FBD1071);
  _id_FC6034154E353165 = ["zxp_ring_high_01", "zxp_ring_high_02", "zxp_ring_high_03"];
  _id_7AB5B649FA408138::_id_B11CFEE3350D246A("br_ring_high", _id_FC6034154E353165);
  _id_3D687AABF72E4E2F = ["zxp_ring_final"];
  _id_7AB5B649FA408138::_id_B11CFEE3350D246A("br_ring_final", _id_3D687AABF72E4E2F);
  _id_0A98588E08A2CF6A = ["mx_mp_br_exfil1"];
  _id_7AB5B649FA408138::_id_B11CFEE3350D246A("br_exfil_intro1", _id_0A98588E08A2CF6A);
  _id_0A98578E08A2CD37 = ["mx_mp_br_exfil2"];
  _id_7AB5B649FA408138::_id_B11CFEE3350D246A("br_exfil_intro2", _id_0A98578E08A2CD37);
  _id_0A98568E08A2CB04 = ["mx_mp_br_exfil3"];
  _id_7AB5B649FA408138::_id_B11CFEE3350D246A("br_exfil_intro3", _id_0A98568E08A2CB04);
  _id_0A98558E08A2C8D1 = ["mx_mp_br_exfil4"];
  _id_7AB5B649FA408138::_id_B11CFEE3350D246A("br_exfil_intro4", _id_0A98558E08A2C8D1);
  _id_0A98548E08A2C69E = ["mx_mp_br_exfil5"];
  _id_7AB5B649FA408138::_id_B11CFEE3350D246A("br_exfil_intro5", _id_0A98548E08A2C69E);
  _id_0A98538E08A2C46B = ["mx_mp_br_exfil6"];
  _id_7AB5B649FA408138::_id_B11CFEE3350D246A("br_exfil_intro6", _id_0A98538E08A2C46B);
  _id_0A98528E08A2C238 = ["mx_mp_br_exfil7"];
  _id_7AB5B649FA408138::_id_B11CFEE3350D246A("br_exfil_intro7", _id_0A98528E08A2C238);
}

_id_0350D33613FA93E9() {
  _id_7AB5B649FA408138::_id_B11CFEE3350D246A("defeat_allies_classic", "mx_mp_generic_lose_1_classic");
  _id_7AB5B649FA408138::_id_B11CFEE3350D246A("victory_allies_classic", "mx_mp_generic_win_2_classic");
  _id_7AB5B649FA408138::_id_B11CFEE3350D246A("draw_allies_classic", "mx_mp_generic_draw_1_classic");

  if(_id_7AB5B649FA408138::_id_5DF2F278F44A6FFD("middle_east")) {
    _id_7AB5B649FA408138::_id_B11CFEE3350D246A("defeat_allies_classic", "mx_mp_mideast_lose_1_classic");
    _id_7AB5B649FA408138::_id_B11CFEE3350D246A("victory_allies_classic", "mx_mp_mideast_win_2_classic");
    _id_7AB5B649FA408138::_id_B11CFEE3350D246A("draw_allies_classic", "mx_mp_mideast_draw_1_classic");
  }

  if(_id_7AB5B649FA408138::_id_5DF2F278F44A6FFD("mexico")) {
    _id_7AB5B649FA408138::_id_B11CFEE3350D246A("defeat_allies_classic", "mx_mp_mexico_lose_1_classic");
    _id_7AB5B649FA408138::_id_B11CFEE3350D246A("victory_allies_classic", "mx_mp_mexico_win_2_classic");
    _id_7AB5B649FA408138::_id_B11CFEE3350D246A("draw_allies_classic", "mx_mp_mexico_draw_2_classic");
  }

  _id_4AC7D75B9F179510 = ["mx_mp_generic_round_win_1_classic", "mx_mp_generic_round_win_2_classic", "mx_mp_generic_round_win_3_classic"];

  if(_id_7AB5B649FA408138::_id_5DF2F278F44A6FFD("middle_east"))
    _id_4AC7D75B9F179510 = ["mx_mp_mideast_round_win_1_classic", "mx_mp_mideast_round_win_2_classic", "mx_mp_mideast_round_win_3_classic"];

  if(_id_7AB5B649FA408138::_id_5DF2F278F44A6FFD("mexico"))
    _id_4AC7D75B9F179510 = ["mx_mp_mexico_round_win_1_classic", "mx_mp_mexico_round_win_2_classic", "mx_mp_mexico_round_win_3_classic"];

  _id_7AB5B649FA408138::_id_B11CFEE3350D246A("roundwin_allies_classic", _id_4AC7D75B9F179510);
  _id_019A44DFD16A9B35 = ["mx_mp_generic_round_lose_1_classic", "mx_mp_generic_round_lose_2_classic", "mx_mp_generic_round_lose_3_classic"];

  if(_id_7AB5B649FA408138::_id_5DF2F278F44A6FFD("middle_east"))
    _id_019A44DFD16A9B35 = ["mx_mp_mideast_round_lose_1_classic", "mx_mp_mideast_round_lose_2_classic", "mx_mp_mideast_round_lose_3_classic", "mx_mp_mideast_round_lose_4_classic"];

  if(_id_7AB5B649FA408138::_id_5DF2F278F44A6FFD("mexico"))
    _id_019A44DFD16A9B35 = ["mx_mp_mexico_round_lose_1_classic", "mx_mp_mexico_round_lose_2_classic", "mx_mp_mexico_round_lose_3_classic"];

  _id_7AB5B649FA408138::_id_B11CFEE3350D246A("roundloss_allies_classic", _id_019A44DFD16A9B35);
  _id_7AB5B649FA408138::_id_B11CFEE3350D246A("defeat_axis_classic", "mx_mp_generic_lose_2_classic");
  _id_7AB5B649FA408138::_id_B11CFEE3350D246A("victory_axis_classic", "mx_mp_generic_win_1_classic");
  _id_7AB5B649FA408138::_id_B11CFEE3350D246A("draw_axis_classic", "mx_mp_generic_draw_2_classic");

  if(_id_7AB5B649FA408138::_id_5DF2F278F44A6FFD("middle_east")) {
    _id_7AB5B649FA408138::_id_B11CFEE3350D246A("defeat_axis_classic", "mx_mp_mideast_lose_2_classic");
    _id_7AB5B649FA408138::_id_B11CFEE3350D246A("victory_axis_classic", "mx_mp_mideast_win_1_classic");
    _id_7AB5B649FA408138::_id_B11CFEE3350D246A("draw_axis_classic", "mx_mp_mideast_draw_2_classic");
  }

  if(_id_7AB5B649FA408138::_id_5DF2F278F44A6FFD("mexico")) {
    _id_7AB5B649FA408138::_id_B11CFEE3350D246A("defeat_axis_classic", "mx_mp_mexico_lose_2_classic");
    _id_7AB5B649FA408138::_id_B11CFEE3350D246A("victory_axis_classic", "mx_mp_mexico_win_1_classic");
    _id_7AB5B649FA408138::_id_B11CFEE3350D246A("draw_axis_classic", "mx_mp_mexico_draw_1_classic");
  }

  _id_E60622B92F4FDE8F = ["mx_mp_generic_timesup_win_1_classic"];
  _id_7AB5B649FA408138::_id_B11CFEE3350D246A("winning_axis_classic", _id_E60622B92F4FDE8F);
  _id_94D7AF818EDF38D7 = ["mx_mp_generic_timesup_lose_1_classic"];
  _id_7AB5B649FA408138::_id_B11CFEE3350D246A("losing_axis_classic", _id_94D7AF818EDF38D7);
  _id_42D2778CC0F1EDCF = ["mx_mp_generic_round_win_1_classic", "mx_mp_generic_round_win_2_classic", "mx_mp_generic_round_win_3_classic"];

  if(_id_7AB5B649FA408138::_id_5DF2F278F44A6FFD("middle_east"))
    _id_42D2778CC0F1EDCF = ["mx_mp_mideast_round_win_1_classic", "mx_mp_mideast_round_win_2_classic", "mx_mp_mideast_round_win_3_classic"];

  if(_id_7AB5B649FA408138::_id_5DF2F278F44A6FFD("mexico"))
    _id_42D2778CC0F1EDCF = ["mx_mp_mexico_round_win_1_classic", "mx_mp_mexico_round_win_2_classic", "mx_mp_mexico_round_win_3_classic"];

  _id_7AB5B649FA408138::_id_B11CFEE3350D246A("roundwin_axis_classic", _id_42D2778CC0F1EDCF);
  _id_26F5C58BB835C5F6 = ["mx_mp_generic_round_lose_1_classic", "mx_mp_generic_round_lose_2_classic", "mx_mp_generic_round_lose_3_classic"];

  if(_id_7AB5B649FA408138::_id_5DF2F278F44A6FFD("middle_east"))
    _id_26F5C58BB835C5F6 = ["mx_mp_mideast_round_lose_1_classic", "mx_mp_mideast_round_lose_2_classic", "mx_mp_mideast_round_lose_3_classic", "mx_mp_mideast_round_lose_4_classic"];

  if(_id_7AB5B649FA408138::_id_5DF2F278F44A6FFD("mexico"))
    _id_26F5C58BB835C5F6 = ["mx_mp_mexico_round_lose_1_classic", "mx_mp_mexico_round_lose_2_classic", "mx_mp_mexico_round_lose_3_classic"];

  _id_7AB5B649FA408138::_id_B11CFEE3350D246A("roundloss_axis_classic", _id_26F5C58BB835C5F6);
  _id_782ADAC6EB79AACB = ["mx_mp_generic_round_draw_1_classic", "mx_mp_generic_round_draw_2_classic", "mx_mp_generic_round_draw_3_classic"];

  if(_id_7AB5B649FA408138::_id_5DF2F278F44A6FFD("middle_east"))
    _id_782ADAC6EB79AACB = ["mx_mp_mideast_round_draw_1_classic", "mx_mp_mideast_round_draw_2_classic", "mx_mp_mideast_round_draw_3_classic", "mx_mp_mideast_round_lose_4_classic"];

  if(_id_7AB5B649FA408138::_id_5DF2F278F44A6FFD("mexico"))
    _id_782ADAC6EB79AACB = ["mx_mp_mexico_round_draw_1_classic", "mx_mp_mexico_round_draw_2_classic", "mx_mp_mexico_round_draw_3_classic"];

  _id_7AB5B649FA408138::_id_B11CFEE3350D246A("rounddraw_classic", _id_782ADAC6EB79AACB);
  _id_6A95AA0C1386C995 = ["mx_dominated_3_classic", "mx_dominated_4_classic"];
  _id_7AB5B649FA408138::_id_B11CFEE3350D246A("dominated_allies_classic", _id_6A95AA0C1386C995);
  _id_F652A139CD9CFCB0 = ["mx_dominating_1_classic", "mx_dominating_2_classic", "mx_dominating_3_classic"];
  _id_7AB5B649FA408138::_id_B11CFEE3350D246A("dominating_allies_classic", _id_F652A139CD9CFCB0);
  _id_6FA22B4241DAF1D6 = ["mx_dominated_1_classic", "mx_dominated_2_classic"];
  _id_7AB5B649FA408138::_id_B11CFEE3350D246A("dominated_axis_classic", _id_6FA22B4241DAF1D6);
  _id_BE46504F50EF356F = ["mx_dominating_1_classic", "mx_dominating_2_classic", "mx_dominating_3_classic"];
  _id_7AB5B649FA408138::_id_B11CFEE3350D246A("dominating_axis_classic", _id_BE46504F50EF356F);
  _id_1CEDCA52AEB31DF4 = ["mp_sd_bombplanted_playlist_classic"];
  _id_7AB5B649FA408138::_id_B11CFEE3350D246A("bombplant_classic", _id_1CEDCA52AEB31DF4);
  _id_3084C90CFC9DAA76 = ["mp_sd_bombplanted_30_playlist_classic"];
  _id_7AB5B649FA408138::_id_B11CFEE3350D246A("bombplant_30_classic", _id_3084C90CFC9DAA76);
  _id_FFDB4AB089874D04 = ["mp_sd_bombplanted_30_playlist_classic"];
  _id_7AB5B649FA408138::_id_B11CFEE3350D246A("bounty_music_classic", _id_FFDB4AB089874D04);
  _id_FC433EA7C9660019 = ["mp_hp_new_playlist_classic"];
  _id_7AB5B649FA408138::_id_B11CFEE3350D246A("hq_new_classic", _id_FC433EA7C9660019);
  _id_C8C37CEA21555F4B = ["mp_hp_captured_playlist_classic"];
  _id_7AB5B649FA408138::_id_B11CFEE3350D246A("hq_captured_classic", _id_C8C37CEA21555F4B);
  _id_348883BA64C7111D = ["mp_hp_destroy_enemy_classic"];
  _id_7AB5B649FA408138::_id_B11CFEE3350D246A("hq_destroyed_pos_classic", _id_348883BA64C7111D);
  _id_66A8997EE06B39ED = ["mp_hp_destroy_team_classic"];
  _id_7AB5B649FA408138::_id_B11CFEE3350D246A("hq_destroyed_neg_classic", _id_66A8997EE06B39ED);
  _id_B524610F7CBA512D = ["mp_hp_new_playlist_classic", "mp_hp_captured_playlist_classic"];
  _id_7AB5B649FA408138::_id_B11CFEE3350D246A("ko_carry_music_classic", _id_B524610F7CBA512D);
  _id_E2C8F02370F9C64B = ["mx_mp_prisoner_generic_1_classic", "mx_mp_prisoner_generic_2_classic"];

  if(_id_7AB5B649FA408138::_id_5DF2F278F44A6FFD("middle_east"))
    _id_E2C8F02370F9C64B = ["mx_mp_prisoner_mideast_1_classic", "mx_mp_prisoner_mideast_2_classic"];

  if(_id_7AB5B649FA408138::_id_5DF2F278F44A6FFD("mexico"))
    _id_E2C8F02370F9C64B = ["mx_mp_prisoner_mexico_1_classic", "mx_mp_prisoner_mexico_2_classic"];

  _id_7AB5B649FA408138::_id_B11CFEE3350D246A("prisoner_carry_music_classic", _id_E2C8F02370F9C64B);
  _id_1B04E5B11841C8E9 = ["mp_sd_bombplanted_playlist_classic"];
  _id_7AB5B649FA408138::_id_B11CFEE3350D246A("plunder_tenpercent_classic", _id_1B04E5B11841C8E9);
  _id_3E2244BE1237E44C = ["mp_sd_bombplanted_playlist_classic"];
  _id_7AB5B649FA408138::_id_B11CFEE3350D246A("plunder_thirtypercent_classic", _id_3E2244BE1237E44C);
  _id_944968FA26125736 = ["mp_hp_captured_playlist_classic"];
  _id_7AB5B649FA408138::_id_B11CFEE3350D246A("plunder_fiftypercent_classic", _id_944968FA26125736);
  _id_80453C8030B89472 = ["mx_mp_generic_timesup_lose_1_classic"];
  _id_7AB5B649FA408138::_id_B11CFEE3350D246A("plunder_seventyfivepercent_classic", _id_80453C8030B89472);
  _id_1E048D50E5E06221 = ["mx_mp_dmz_activity_action_loop1_classic"];
  _id_7AB5B649FA408138::_id_B11CFEE3350D246A("plunder_ninetypercent_classic", _id_1E048D50E5E06221);
  _id_5FF38DDFE0CE22E4 = ["mx_mp_br_circle_close_final_loop_1_classic", "mx_mp_br_circle_close_final_loop_2_classic"];
  _id_7AB5B649FA408138::_id_B11CFEE3350D246A("plunder_bonustime_long_classic", _id_5FF38DDFE0CE22E4);
  _id_8B0C0A46F9743150();
}

_id_8B0C0A46F9743150() {
  if(_id_7AB5B649FA408138::_id_5DF2F278F44A6FFD("middle_east"))
    _id_153A99861F60905C = ["mx_mp_mideast_infil_2_classic"];
  else if(_id_7AB5B649FA408138::_id_5DF2F278F44A6FFD("mexico"))
    _id_153A99861F60905C = ["mx_mp_mexico_infil_1_classic"];
  else
    _id_153A99861F60905C = ["mx_mp_generic_infil_1_classic"];

  _id_7AB5B649FA408138::_id_B11CFEE3350D246A("spawn_allies_classic", _id_153A99861F60905C);

  if(_id_7AB5B649FA408138::_id_5DF2F278F44A6FFD("middle_east"))
    _id_45829EF4901DD783 = ["mx_mp_mideast_infil_1_classic"];
  else if(_id_7AB5B649FA408138::_id_5DF2F278F44A6FFD("mexico"))
    _id_45829EF4901DD783 = ["mx_mp_mexico_infil_2_classic"];
  else
    _id_45829EF4901DD783 = ["mx_mp_generic_infil_2_classic"];

  _id_7AB5B649FA408138::_id_B11CFEE3350D246A("spawn_axis_classic", _id_45829EF4901DD783);
  _id_46193B4645370557 = ["mx_mp_generic_infil_2_classic"];

  if(_id_7AB5B649FA408138::_id_5DF2F278F44A6FFD("middle_east"))
    _id_46193B4645370557 = ["mx_mp_mideast_infil_1_classic"];

  if(_id_7AB5B649FA408138::_id_5DF2F278F44A6FFD("mexico"))
    _id_46193B4645370557 = ["mx_mp_mexico_infil_2_classic"];

  _id_7AB5B649FA408138::_id_B11CFEE3350D246A("east_animated_infil_classic", _id_46193B4645370557);
  _id_3F003733117D0F29 = ["mx_mp_generic_infil_1_classic"];

  if(_id_7AB5B649FA408138::_id_5DF2F278F44A6FFD("middle_east"))
    _id_3F003733117D0F29 = ["mx_mp_mideast_infil_2_classic"];

  if(_id_7AB5B649FA408138::_id_5DF2F278F44A6FFD("mexico"))
    _id_3F003733117D0F29 = ["mx_mp_mexico_infil_1_classic"];

  _id_7AB5B649FA408138::_id_B11CFEE3350D246A("west_animated_infil_classic", _id_3F003733117D0F29);
  _id_F26070BC64E53DCB = ["mx_mp_gunfight_west_infil_1_classic", "mx_mp_gunfight_west_infil_2_classic", "mx_mp_gunfight_west_infil_3_classic", "mx_mp_gunfight_west_infil_4_classic", "mx_mp_gunfight_west_infil_5_classic"];
  _id_7AB5B649FA408138::_id_B11CFEE3350D246A("gunfight_spawn_classic", _id_F26070BC64E53DCB);
  _id_B9855F487EE17F6E = ["mx_mp_gunfight_early_win_1_classic", "mx_mp_gunfight_early_win_2_classic", "mx_mp_gunfight_early_win_3_classic", "mx_mp_gunfight_early_win_4_classic"];
  _id_7AB5B649FA408138::_id_B11CFEE3350D246A("gunfight_roundwin_early_classic", _id_B9855F487EE17F6E);
  _id_9331B2C978B32857 = ["mx_mp_gunfight_early_loss_1_classic", "mx_mp_gunfight_early_loss_2_classic", "mx_mp_gunfight_early_loss_3_classic", "mx_mp_gunfight_early_loss_4_classic"];
  _id_7AB5B649FA408138::_id_B11CFEE3350D246A("gunfight_roundloss_early_classic", _id_9331B2C978B32857);
  _id_5BD57D9760153CFB = ["mx_mp_gunfight_mid_win_1_classic", "mx_mp_gunfight_mid_win_2_classic", "mx_mp_gunfight_mid_win_3_classic", "mx_mp_gunfight_mid_win_4_classic"];
  _id_7AB5B649FA408138::_id_B11CFEE3350D246A("gunfight_roundwin_mid_classic", _id_5BD57D9760153CFB);
  _id_A115843C5D0EE51A = ["mx_mp_gunfight_mid_loss_1_classic", "mx_mp_gunfight_mid_loss_2_classic", "mx_mp_gunfight_mid_loss_3_classic", "mx_mp_gunfight_mid_loss_4_classic", "mx_mp_gunfight_mid_loss_5_classic"];
  _id_7AB5B649FA408138::_id_B11CFEE3350D246A("gunfight_roundloss_mid_classic", _id_A115843C5D0EE51A);
  _id_802428414A10843F = ["mx_mp_gunfight_late_win_1_classic", "mx_mp_gunfight_late_win_2_classic", "mx_mp_gunfight_late_win_3_classic", "mx_mp_gunfight_late_win_4_classic", "mx_mp_gunfight_late_win_5_classic"];
  _id_7AB5B649FA408138::_id_B11CFEE3350D246A("gunfight_roundwin_late_classic", _id_802428414A10843F);
  _id_0B86D2B2C0C95420 = ["mx_mp_gunfight_late_loss_1_classic", "mx_mp_gunfight_late_loss_2_classic", "mx_mp_gunfight_late_loss_3_classic", "mx_mp_gunfight_late_loss_4_classic"];
  _id_7AB5B649FA408138::_id_B11CFEE3350D246A("gunfight_roundloss_late_classic", _id_0B86D2B2C0C95420);
  _id_7CAC3993CD7DA309 = ["mx_mp_br_prelobby_outro_classic"];
  _id_7AB5B649FA408138::_id_B11CFEE3350D246A("br_lobby_outro_classic", _id_7CAC3993CD7DA309);
  _id_6BA6E41C20DC40FA = ["mx_mp_br_infil_1_classic"];
  _id_7AB5B649FA408138::_id_B11CFEE3350D246A("br_infil_intro_classic", _id_6BA6E41C20DC40FA);
  _id_AF0951BBDBF11435 = ["mx_mp_br_gulag_lose_classic"];
  _id_7AB5B649FA408138::_id_B11CFEE3350D246A("br_gulag_lose_classic", _id_AF0951BBDBF11435);
  _id_D7FB404AEDFA9814 = ["mx_mp_br_gulag_win_classic"];
  _id_7AB5B649FA408138::_id_B11CFEE3350D246A("br_gulag_win_classic", _id_D7FB404AEDFA9814);
  _id_215D804AA8298F86 = ["mx_mp_br_circle_close_low_1_classic", "mx_mp_br_circle_close_low_2_classic"];
  _id_7AB5B649FA408138::_id_B11CFEE3350D246A("br_ring_low_classic", _id_215D804AA8298F86);
  _id_E9D445F03054219E = ["mx_mp_br_circle_close_med_1_classic", "mx_mp_br_circle_close_med_2_classic"];
  _id_7AB5B649FA408138::_id_B11CFEE3350D246A("br_ring_med_classic", _id_E9D445F03054219E);
  _id_E827F03DF38DDF32 = ["mx_mp_br_circle_close_high_1_classic", "mx_mp_br_circle_close_high_2_classic"];
  _id_7AB5B649FA408138::_id_B11CFEE3350D246A("br_ring_high_classic", _id_E827F03DF38DDF32);
  _id_2E5446C250EBFBF0 = ["mx_mp_br_circle_close_final_loop_1_classic", "mx_mp_br_circle_close_final_loop_2_classic"];
  _id_7AB5B649FA408138::_id_B11CFEE3350D246A("br_ring_final_classic", _id_2E5446C250EBFBF0);
  _id_2BCE903E4AFB1631 = ["mx_mp_br_exfil1_classic"];
  _id_7AB5B649FA408138::_id_B11CFEE3350D246A("br_exfil_intro1_classic", _id_2BCE903E4AFB1631);
  _id_E1854A416D1721E8 = ["mx_mp_br_exfil2_classic"];
  _id_7AB5B649FA408138::_id_B11CFEE3350D246A("br_exfil_intro2_classic", _id_E1854A416D1721E8);
  _id_94D1C12A22DF04DF = ["mx_mp_br_exfil3_classic"];
  _id_7AB5B649FA408138::_id_B11CFEE3350D246A("br_exfil_intro3_classic", _id_94D1C12A22DF04DF);
  _id_5B9ACC947FC6533E = ["mx_mp_br_exfil4_classic"];
  _id_7AB5B649FA408138::_id_B11CFEE3350D246A("br_exfil_intro4_classic", _id_5B9ACC947FC6533E);
  _id_12EBC612B465C625 = ["mx_mp_br_exfil5_classic"];
  _id_7AB5B649FA408138::_id_B11CFEE3350D246A("br_exfil_intro5_classic", _id_12EBC612B465C625);
  _id_D6D90D732E059F1C = ["mx_mp_br_exfil6_classic"];
  _id_7AB5B649FA408138::_id_B11CFEE3350D246A("br_exfil_intro6_classic", _id_D6D90D732E059F1C);
  _id_BE1FAF3AE1F5FC33 = ["mx_mp_br_exfil6_classic"];
  _id_7AB5B649FA408138::_id_B11CFEE3350D246A("br_exfil_intro7_classic", _id_BE1FAF3AE1F5FC33);
  _id_C31F2501156B196B = ["mx_mp_br_elitecontracts_elementfound_1_classic", "mx_mp_br_elitecontracts_elementfound_2_classic", "mx_mp_br_elitecontracts_elementfound_3_classic"];
  _id_7AB5B649FA408138::_id_B11CFEE3350D246A("br_elite_arrow_element_classic", _id_C31F2501156B196B);
  _id_C3E230FDA23AD937 = ["mx_mp_br_elitecontracts_bombarmed_1_classic"];
  _id_7AB5B649FA408138::_id_B11CFEE3350D246A("br_elite_arrow_bomb_armed_classic", _id_C3E230FDA23AD937);
  _id_CD3ABDC3957AD5B6 = ["iw9_mp_dmz_infil1_classic", "iw9_mp_dmz_infil2_classic", "iw9_mp_dmz_infil3_classic", "iw9_mp_dmz_infil4_classic", "iw9_mp_dmz_infil5_classic"];
  _id_7AB5B649FA408138::_id_B11CFEE3350D246A("dmz_infil_classic", _id_CD3ABDC3957AD5B6);
  _id_BE1CA81FC3DCCCD8 = ["iw9_mp_dmz_activity_start_classic"];
  _id_7AB5B649FA408138::_id_B11CFEE3350D246A("dmz_activity_start_classic", _id_BE1CA81FC3DCCCD8);
  _id_A55DBF4A91704962 = ["iw9_mp_dmz_activity_tension_classic"];
  _id_7AB5B649FA408138::_id_B11CFEE3350D246A("dmz_activity_tension_classic", _id_A55DBF4A91704962);
  _id_94A7A4AC93C16E18 = ["iw9_mp_dmz_activity_action_classic"];
  _id_7AB5B649FA408138::_id_B11CFEE3350D246A("dmz_activity_action_classic", _id_94A7A4AC93C16E18);
  _id_EAED847B415CDE8E = ["iw9_mp_dmz_activity_won_classic"];
  _id_7AB5B649FA408138::_id_B11CFEE3350D246A("dmz_activity_win_classic", _id_EAED847B415CDE8E);
  _id_DC3CC4C96276713B = ["iw9_mp_dmz_activity_lose_classic"];
  _id_7AB5B649FA408138::_id_B11CFEE3350D246A("dmz_activity_lose_classic", _id_DC3CC4C96276713B);
  _id_3B56F017CDD1EBCB = ["iw9_mp_dmz_exfil1_classic", "iw9_mp_dmz_exfil2_classic"];
  _id_7AB5B649FA408138::_id_B11CFEE3350D246A("dmz_exfil_start_classic", _id_3B56F017CDD1EBCB);
  _id_8DBAAF79BCB57E9F = ["dmz_stronghold_unlock_classic"];
  _id_7AB5B649FA408138::_id_B11CFEE3350D246A("dmz_stronghold_unlock_classic", _id_8DBAAF79BCB57E9F);
  _id_F2821618DF896466 = ["dmz_elimination_accept_classic"];
  _id_7AB5B649FA408138::_id_B11CFEE3350D246A("dmz_elimination_start_classic", _id_F2821618DF896466);
  _id_0CECD2DAB77946A4 = ["dmz_elimination_approach_classic"];
  _id_7AB5B649FA408138::_id_B11CFEE3350D246A("dmz_elimination_approach_classic", _id_0CECD2DAB77946A4);
  _id_F2760738CBC767FC = ["dmz_elimination_kill_classic"];
  _id_7AB5B649FA408138::_id_B11CFEE3350D246A("dmz_elimination_win_classic", _id_F2760738CBC767FC);
  _id_3B993A5A20F3110F = ["dmz_geigersearch_pickups_classic"];
  _id_7AB5B649FA408138::_id_B11CFEE3350D246A("dmz_geigersearch_pickups_classic", _id_3B993A5A20F3110F);
  _id_B2B5793BD51F85E2 = ["dmz_fortress_hostage_contract_classic"];
  _id_7AB5B649FA408138::_id_B11CFEE3350D246A("dmz_hostage_start_classic", _id_B2B5793BD51F85E2);
  _id_A2E026D025B42D30 = ["dmz_fortress_hostage_approach_classic"];
  _id_7AB5B649FA408138::_id_B11CFEE3350D246A("dmz_hostage_approach_classic", _id_A2E026D025B42D30);
  _id_2E70B4BB77BB735D = ["dmz_stronghold_unlock_classic"];
  _id_7AB5B649FA408138::_id_B11CFEE3350D246A("dmz_hostage_breach_classic", _id_2E70B4BB77BB735D);
  _id_1C094CC7552A8779 = ["dmz_fortress_hostage_rescue_classic"];
  _id_7AB5B649FA408138::_id_B11CFEE3350D246A("dmz_hostage_rescue_classic", _id_1C094CC7552A8779);
  _id_23D59AF1A8DBD689 = ["dmz_fortress_hostage_rescuefailed_classic"];
  _id_7AB5B649FA408138::_id_B11CFEE3350D246A("dmz_hostage_rescue_failed_classic", _id_23D59AF1A8DBD689);
  _id_ED8841DDD54DF306 = ["dmz_trap_assigned_classic"];
  _id_7AB5B649FA408138::_id_B11CFEE3350D246A("dmz_trap_start_classic", _id_ED8841DDD54DF306);
  _id_AEB8BE8104AAEBC4 = ["dmz_trap_approach_classic"];
  _id_7AB5B649FA408138::_id_B11CFEE3350D246A("dmz_trap_approach_classic", _id_AEB8BE8104AAEBC4);
  _id_5CAE60CE3236482F = ["dmz_trap_drill_classic"];
  _id_7AB5B649FA408138::_id_B11CFEE3350D246A("dmz_trap_drill_classic", _id_5CAE60CE3236482F);
  _id_6EC541EBFB79447A = ["mx_mp_dmz_safecracker_train_loop_classic"];
  _id_7AB5B649FA408138::_id_B11CFEE3350D246A("dmz_train_safe_drill_classic", _id_6EC541EBFB79447A);
  _id_9BE07D4DA97C507B = ["zc_points_streak_classic"];
  _id_7AB5B649FA408138::_id_B11CFEE3350D246A("zc_zone_streak_main_classic", _id_9BE07D4DA97C507B);
}

_id_ED24376A19A1B0FE() {
  if(!isDefined(game["dialogue"])) {
    game["dialogue"]["axis_male_cough"] = [];
    game["dialogue"]["axis_male_cough"][game["dialogue"]["axis_male_cough"].size] = "generic_cough_3_enemy_1";
    game["dialogue"]["axis_male_cough"][game["dialogue"]["axis_male_cough"].size] = "generic_cough_3_enemy_2";
    game["dialogue"]["axis_male_cough"][game["dialogue"]["axis_male_cough"].size] = "generic_cough_3_enemy_3";
    game["dialogue"]["axis_male_cough"][game["dialogue"]["axis_male_cough"].size] = "generic_cough_3_enemy_4";
    game["dialogue"]["axis_male_cough"][game["dialogue"]["axis_male_cough"].size] = "generic_cough_3_enemy_5";
    game["dialogue"]["axis_male_cough"][game["dialogue"]["axis_male_cough"].size] = "generic_cough_3_enemy_6";
    game["dialogue"]["axis_male_cough"][game["dialogue"]["axis_male_cough"].size] = "generic_cough_3_enemy_7";
    game["dialogue"]["axis_male_cough"][game["dialogue"]["axis_male_cough"].size] = "generic_cough_3_enemy_8";
    game["dialogue"]["axis_male_cough"][game["dialogue"]["axis_male_cough"].size] = "generic_cough_fit_enemy_1";
    game["dialogue"]["axis_male_cough"][game["dialogue"]["axis_male_cough"].size] = "generic_cough_fit_enemy_2";
    game["dialogue"]["axis_male_cough"][game["dialogue"]["axis_male_cough"].size] = "generic_cough_fit_enemy_3";
    game["dialogue"]["axis_male_cough"][game["dialogue"]["axis_male_cough"].size] = "generic_cough_fit_enemy_4";
    game["dialogue"]["axis_male_cough"][game["dialogue"]["axis_male_cough"].size] = "generic_cough_fit_enemy_5";
    game["dialogue"]["axis_male_cough"][game["dialogue"]["axis_male_cough"].size] = "generic_cough_fit_enemy_6";
    game["dialogue"]["axis_male_cough"][game["dialogue"]["axis_male_cough"].size] = "generic_cough_fit_enemy_7";
    game["dialogue"]["axis_male_cough"][game["dialogue"]["axis_male_cough"].size] = "generic_cough_fit_enemy_8";
    game["dialogue"]["axis_female_cough"] = [];
    game["dialogue"]["axis_female_cough"][game["dialogue"]["axis_female_cough"].size] = "woman_cough_3_friendly_1";
    game["dialogue"]["axis_female_cough"][game["dialogue"]["axis_female_cough"].size] = "woman_cough_3_friendly_2";
    game["dialogue"]["axis_female_cough"][game["dialogue"]["axis_female_cough"].size] = "woman_cough_3_friendly_3";
    game["dialogue"]["axis_female_cough"][game["dialogue"]["axis_female_cough"].size] = "woman_cough_3_friendly_4";
    game["dialogue"]["axis_female_cough"][game["dialogue"]["axis_female_cough"].size] = "woman_cough_3_friendly_5";
    game["dialogue"]["axis_female_cough"][game["dialogue"]["axis_female_cough"].size] = "woman_cough_3_friendly_6";
    game["dialogue"]["axis_female_cough"][game["dialogue"]["axis_female_cough"].size] = "woman_cough_3_friendly_7";
    game["dialogue"]["axis_female_cough"][game["dialogue"]["axis_female_cough"].size] = "woman_cough_3_friendly_8";
    game["dialogue"]["axis_female_cough"][game["dialogue"]["axis_female_cough"].size] = "woman_cough_fit_friendly_1";
    game["dialogue"]["axis_female_cough"][game["dialogue"]["axis_female_cough"].size] = "woman_cough_fit_friendly_2";
    game["dialogue"]["axis_female_cough"][game["dialogue"]["axis_female_cough"].size] = "woman_cough_fit_friendly_3";
    game["dialogue"]["axis_female_cough"][game["dialogue"]["axis_female_cough"].size] = "woman_cough_fit_friendly_4";
    game["dialogue"]["axis_female_cough"][game["dialogue"]["axis_female_cough"].size] = "woman_cough_fit_friendly_5";
    game["dialogue"]["axis_female_cough"][game["dialogue"]["axis_female_cough"].size] = "woman_cough_fit_friendly_6";
    game["dialogue"]["axis_female_cough"][game["dialogue"]["axis_female_cough"].size] = "woman_cough_fit_friendly_7";
    game["dialogue"]["axis_female_cough"][game["dialogue"]["axis_female_cough"].size] = "woman_cough_fit_friendly_8";
    game["dialogue"]["allies_male_cough"] = [];
    game["dialogue"]["allies_male_cough"][game["dialogue"]["allies_male_cough"].size] = "generic_cough_3_friendly_1";
    game["dialogue"]["allies_male_cough"][game["dialogue"]["allies_male_cough"].size] = "generic_cough_3_friendly_2";
    game["dialogue"]["allies_male_cough"][game["dialogue"]["allies_male_cough"].size] = "generic_cough_3_friendly_3";
    game["dialogue"]["allies_male_cough"][game["dialogue"]["allies_male_cough"].size] = "generic_cough_3_friendly_4";
    game["dialogue"]["allies_male_cough"][game["dialogue"]["allies_male_cough"].size] = "generic_cough_3_friendly_5";
    game["dialogue"]["allies_male_cough"][game["dialogue"]["allies_male_cough"].size] = "generic_cough_3_friendly_6";
    game["dialogue"]["allies_male_cough"][game["dialogue"]["allies_male_cough"].size] = "generic_cough_3_friendly_7";
    game["dialogue"]["allies_male_cough"][game["dialogue"]["allies_male_cough"].size] = "generic_cough_3_friendly_8";
    game["dialogue"]["allies_male_cough"][game["dialogue"]["allies_male_cough"].size] = "generic_cough_fit_friendly_1";
    game["dialogue"]["allies_male_cough"][game["dialogue"]["allies_male_cough"].size] = "generic_cough_fit_friendly_2";
    game["dialogue"]["allies_male_cough"][game["dialogue"]["allies_male_cough"].size] = "generic_cough_fit_friendly_3";
    game["dialogue"]["allies_male_cough"][game["dialogue"]["allies_male_cough"].size] = "generic_cough_fit_friendly_4";
    game["dialogue"]["allies_male_cough"][game["dialogue"]["allies_male_cough"].size] = "generic_cough_fit_friendly_5";
    game["dialogue"]["allies_male_cough"][game["dialogue"]["allies_male_cough"].size] = "generic_cough_fit_friendly_6";
    game["dialogue"]["allies_male_cough"][game["dialogue"]["allies_male_cough"].size] = "generic_cough_fit_friendly_7";
    game["dialogue"]["allies_male_cough"][game["dialogue"]["allies_male_cough"].size] = "generic_cough_fit_friendly_8";
    game["dialogue"]["allies_female_cough"] = [];
    game["dialogue"]["allies_female_cough"][game["dialogue"]["allies_female_cough"].size] = "woman_cough_3_friendly_1";
    game["dialogue"]["allies_female_cough"][game["dialogue"]["allies_female_cough"].size] = "woman_cough_3_friendly_2";
    game["dialogue"]["allies_female_cough"][game["dialogue"]["allies_female_cough"].size] = "woman_cough_3_friendly_3";
    game["dialogue"]["allies_female_cough"][game["dialogue"]["allies_female_cough"].size] = "woman_cough_3_friendly_4";
    game["dialogue"]["allies_female_cough"][game["dialogue"]["allies_female_cough"].size] = "woman_cough_3_friendly_5";
    game["dialogue"]["allies_female_cough"][game["dialogue"]["allies_female_cough"].size] = "woman_cough_3_friendly_6";
    game["dialogue"]["allies_female_cough"][game["dialogue"]["allies_female_cough"].size] = "woman_cough_3_friendly_7";
    game["dialogue"]["allies_female_cough"][game["dialogue"]["allies_female_cough"].size] = "woman_cough_3_friendly_8";
    game["dialogue"]["allies_female_cough"][game["dialogue"]["allies_female_cough"].size] = "woman_cough_fit_friendly_1";
    game["dialogue"]["allies_female_cough"][game["dialogue"]["allies_female_cough"].size] = "woman_cough_fit_friendly_2";
    game["dialogue"]["allies_female_cough"][game["dialogue"]["allies_female_cough"].size] = "woman_cough_fit_friendly_3";
    game["dialogue"]["allies_female_cough"][game["dialogue"]["allies_female_cough"].size] = "woman_cough_fit_friendly_4";
    game["dialogue"]["allies_female_cough"][game["dialogue"]["allies_female_cough"].size] = "woman_cough_fit_friendly_5";
    game["dialogue"]["allies_female_cough"][game["dialogue"]["allies_female_cough"].size] = "woman_cough_fit_friendly_6";
    game["dialogue"]["allies_female_cough"][game["dialogue"]["allies_female_cough"].size] = "woman_cough_fit_friendly_7";
    game["dialogue"]["allies_female_cough"][game["dialogue"]["allies_female_cough"].size] = "woman_cough_fit_friendly_8";
    game["dialog"]["timesup"] = "iw9_gmst_anno_uktl_gsta";
    game["dialog"]["timesup_sixty"] = "iw9_gmst_anno_uktl_gstd";
    game["dialog"]["timesup_thirty"] = "iw9_gmst_anno_uktl_gstc";
    game["dialog"]["timesup_ten"] = "iw9_gmst_anno_uktl_gstb";
    game["dialog"]["winning"] = "iw9_gmst_anno_uktl_gswa";
    game["dialog"]["winning_time"] = "iw9_gmst_anno_uktl_gswb";
    game["dialog"]["winning_score"] = "iw9_gmst_anno_uktl_gswc";
    game["dialog"]["winning_comeback"] = "iw9_gmst_anno_uktl_gswd";
    game["dialog"]["losing"] = "iw9_gmst_anno_uktl_gsla";
    game["dialog"]["losing_time"] = "iw9_gmst_anno_uktl_gslb";
    game["dialog"]["losing_score"] = "iw9_gmst_anno_uktl_gslc";
    game["dialog"]["lead_lost"] = "iw9_gmst_anno_uktl_gsld";
    game["dialog"]["lead_tied"] = "iw9_gmst_anno_uktl_gslf";
    game["dialog"]["lead_taken"] = "iw9_gmst_anno_uktl_gsle";
    game["dialog"]["halftime"] = "iw9_gmst_anno_uktl_gsht";
    game["dialog"]["overtime"] = "iw9_gmst_anno_uktl_gsot";
    game["dialog"]["side_switch"] = "iw9_gmst_anno_uktl_gsss";
    game["dialog"]["last_alive"] = "iw9_gmst_anno_uktl_gslr";

    if(!isDefined(game["dialog"]["halfway_enemy_score"]))
      game["dialog"]["halfway_enemy_score"] = "iw9_gmst_anno_uktl_gshd";

    if(!isDefined(game["dialog"]["halfway_enemy_time"]))
      game["dialog"]["halfway_enemy_time"] = "iw9_gmst_anno_uktl_gshc";

    if(!isDefined(game["dialog"]["halfway_friendly_score"]))
      game["dialog"]["halfway_friendly_score"] = "iw9_gmst_anno_uktl_gshb";

    if(!isDefined(game["dialog"]["halfway_friendly_time"]))
      game["dialog"]["halfway_friendly_time"] = "iw9_gmst_anno_uktl_gsha";

    if(!isDefined(game["dialog"]["boost"]))
      game["dialog"]["boost"] = "iw9_gmst_anno_uktl_gsbo";

    if(!isDefined(game["dialog"]["offense_obj"]))
      game["dialog"]["offense_obj"] = "iw9_gmst_anno_uktl_gsbo";

    if(!isDefined(game["dialog"]["defense_obj"]))
      game["dialog"]["defense_obj"] = "iw9_gmst_anno_uktl_gsbo";

    game["dialog"]["obj_defend"] = "iw9_gmst_anno_uktl_gsoa";
    game["dialog"]["objs_defend"] = "iw9_gmst_anno_uktl_gsob";
    game["dialog"]["obj_destroy"] = "iw9_gmst_anno_uktl_gsoc";
    game["dialog"]["objs_destroy"] = "iw9_gmst_anno_uktl_gsod";
    game["dialog"]["obj_capture"] = "iw9_gmst_anno_uktl_gsoe";
    game["dialog"]["objs_capture"] = "iw9_gmst_anno_uktl_gsof";
    game["dialog"]["captured_all_enemy"] = "iw9_gmst_anno_uktl_gsce";
    game["dialog"]["captured_all_friendly"] = "iw9_gmst_anno_uktl_gscf";
    game["dialog"]["ti_destroyed"] = "iw9_gmst_anno_uktl_gsti";
    game["dialog"]["revived"] = "iw9_gmst_anno_uktl_gsrv";
  }

  game["dialog"]["mission_success"] = "iw9_gmst_anno_uktl_gsms";
  game["dialog"]["mission_failure"] = "iw9_gmst_anno_uktl_gsmf";
  game["dialog"]["mission_draw"] = "iw9_gmst_anno_uktl_gsmt";
  game["dialog"]["round_success"] = "iw9_gmst_anno_uktl_gsrs";
  game["dialog"]["round_failure"] = "iw9_gmst_anno_uktl_gsrf";
  game["dialog"]["round_draw"] = "iw9_gmst_anno_uktl_gsrt";
}

_id_6CA37AF6683E78EC() {
  scripts\mp\utility\spawn_event_aggregator::registeronplayerspawncallback(::onplayerspawned);
  level thread onplayerconnect();
  level thread onlastalive();
  level thread musiccontroller();
  level thread ongameended();
  level thread onroundswitch();

  if(scripts\cp_mp\utility\game_utility::_id_6C1FCE6F6B8779D5() == "gwai") {
    setDvar("dvar_58A078A367C02AB3", 1);
    setDvar("voice_proximity_radius", 1500);
  }
}

onplayerconnect() {
  for(;;) {
    level waittill("connected", player);
    _id_ACFBB9CAED7125F9 = player getplayerdata("common", "commonCustomization", "musicbox");

    if(getdvarint("dvar_61E9133B2E499A6C") == 1)
      _id_ACFBB9CAED7125F9 = 1;

    player._id_ACFBB9CAED7125F9 = _id_ACFBB9CAED7125F9;

    if(getdvarint("dvar_2BE93DD484220A45", 0) == 1)
      player setsoundsubmix("fade_to_black_all_except_music_scripted5_and_amb", 1.0);

    if(scripts\cp_mp\utility\game_utility::_id_6C1FCE6F6B8779D5() == "dmz")
      player thread _id_8FFC5AC70256254B();

    player thread playflyoveraudioline();
    player thread watchhostmigration();
    player.needtoplayintro = 1;
  }
}

onplayerspawned() {
  setdvarifuninitialized("dvar_61E9133B2E499A6C", 0);

  if(isai(self)) {
    return;
  }
  if(istrue(self.needtoplayintro)) {
    thread dointro();
    self.needtoplayintro = undefined;
  }

  if(scripts\mp\utility\game::getgametype() == "arm" || scripts\mp\utility\game::getgametype() == "conflict" || scripts\mp\utility\game::getgametype() == "risk" || scripts\mp\utility\game::getgametype() == "gwbomb" || scripts\mp\utility\game::getgametype() == "gwtdm" || scripts\mp\utility\game::isgroundwarcoremode())
    self setsoundsubmix("iw9_mp_groundwar_focus");
  else if(getdvarint("dvar_2BE93DD484220A45", 0) == 1)
    self setsoundsubmix("iw9_mp_jup_reveal_focus");
  else if(scripts\cp_mp\utility\game_utility::_id_0BEFF479639E6508())
    self setsoundsubmix("iw9_mp_br_focus");
  else if(scripts\mp\utility\game::getgametype() == "ballmode")
    self setsoundsubmix("iw9_mp_soccer");
  else
    self setsoundsubmix("iw9_mp_core_focus");

  if(scripts\mp\utility\game::getsubgametype() == "dmz" && level.mapname == "mp_sealion")
    self setsoundsubmix("iw9_mp_sealion_dmz");
}

_id_8FFC5AC70256254B() {
  self endon("disconnect");
  _id_6A1D06B01F51312E = scripts\cp_mp\utility\game_utility::_id_6C1FCE6F6B8779D5() == "dmz";
  _id_CDEE7F83A96700F2 = getdvarint("dvar_9C43B60485FBD92E", 0) == 0;

  if(!istrue(_id_6A1D06B01F51312E) || getdvarint("dvar_2BE93DD484220A45", 0) == 1) {
    return;
  }
  if(isDefined(self._id_ACFBB9CAED7125F9) && self._id_ACFBB9CAED7125F9 == 1) {
    _id_CD3ABDC3957AD5B6 = _id_7AB5B649FA408138::_id_17EE301CF0B5BA85("dmz_infil_classic");
    self setplayermusicstate(_id_CD3ABDC3957AD5B6);
  } else {
    _id_454118824CC58D59 = _id_7AB5B649FA408138::_id_17EE301CF0B5BA85("dmz_infil");
    self setplayermusicstate(_id_454118824CC58D59);
  }

  if(istrue(_id_CDEE7F83A96700F2)) {
    self setsoundsubmix("solo_cin_igc_music", 0.0);

    while(!scripts\mp\flags::gameflag("prematch_done")) {
      if(istrue(level._id_466A09C79541FC26) || isnumber(level.matchcountdowntime) && level.matchcountdowntime <= 3) {
        break;
      }

      waitframe();
    }

    waitframe();
    self clearsoundsubmix("solo_cin_igc_music", 2.0);
  }

  if(isDefined(level.prematchperiod)) {
    while(!scripts\mp\flags::gameflag("prematch_done"))
      waitframe();
  }

  waittillframeend;
  self setplayermusicstate("");
}

waitcountdown() {
  level endon("host_migration_begin");
  self endon("disconnect");

  for(;;) {
    if(scripts\mp\flags::gameflag("prematch_done")) {
      self notify("luinotifyserver", "matchReady");
      return;
    }

    wait 1;
  }
}

playflyoveraudioline() {
  level endon("host_migration_begin");
  self endon("disconnect");
  _id_C924752368853F99 = scripts\mp\utility\game::gettimepassed() / 1000 + 6;

  if(_id_C924752368853F99 >= level.prematchperiod) {
    return;
  }
  if(!level.rankedmatch) {
    return;
  }
  if(!scripts\mp\utility\game::rankingenabled()) {
    return;
  }
  _id_0672820B647EC78D = 0;

  if(!self issplitscreenplayer() || self issplitscreenplayerprimary()) {
    if(self.sessionteam == "allies") {
      switch (_id_0672820B647EC78D) {
        case 0:
          self playannouncersound("jtfw_mtc1_un_flyover");
          break;
        case 1:
          self playannouncersound("oi_mtc3_un_flyover");
          break;
        case 2:
          self playannouncersound("st7_mtc4_prematch_flyover");
          break;
        case 3:
          self playannouncersound("wr_mtc5_un_flyover");
          break;
        case 4:
          self playannouncersound("ba_mtc2_un_flyover");
          break;
        default:
          break;
      }
    } else if(self.sessionteam == "axis") {
      switch (_id_0672820B647EC78D) {
        case 0:
          self playannouncersound("jtfw_mtc1_sdf_flyover");
          break;
        case 1:
          self playannouncersound("oi_mtc3_sdf_flyover");
          break;
        case 2:
          self playannouncersound("st7_mtc4_prematch_flyover");
          break;
        case 3:
          self playannouncersound("wr_mtc5_sdf_flyover");
          break;
        case 4:
          self playannouncersound("ba_mtc2_sdf_flyover");
          break;
        default:
          break;
      }
    }
  }
}

dointro() {
  level endon("game_ended");
  level endon("host_migration_begin");
  self endon("disconnect");

  while(level.ingraceperiod > 15)
    waitframe();

  if(!isDefined(level.infilvotiming) && scripts\mp\utility\game::teamhasinfil(self.team) && game["roundsPlayed"] == 0)
    level.infilvotiming = 1;

  if(isDefined(game["trial"]) && isDefined(game["trial"]["tries_remaining"]) && game["trial"]["tries_remaining"] < 3) {
    return;
  }
  if(scripts\mp\utility\game::getgametype() == "arena") {
    waiting = 0;
    thread _id_99EBE915CE92EB6F();
  } else
    waiting = !scripts\mp\flags::gameflag("prematch_done") && (!scripts\mp\utility\game::isroundbased() || scripts\mp\utility\game::isfirstround());

  if(waiting) {
    thread waitcountdown();
    thread _id_99EBE915CE92EB6F();
    self setsoundsubmix("iw9_mp_core_prematch");

    for(;;) {
      self waittill("luinotifyserver", result, value);

      if(result == "matchReady") {
        break;
      }
    }
  }

  self clearsoundsubmix("iw9_mp_core_prematch", 2);

  if(istrue(level.infilvotiming)) {
    scripts\mp\flags::gameflagwait("prematch_done");
    wait 1.5;
  }

  if(isDefined(game["dialog"]["gametype"]) && (!level.splitscreen || self == level.players[0])) {
    if(isDefined(game["dialog"]["allies_gametype"]) && self.team == "allies")
      scripts\mp\utility\dialog::leaderdialogonplayer("allies_gametype");
    else if(isDefined(game["dialog"]["axis_gametype"]) && self.team == "axis")
      scripts\mp\utility\dialog::leaderdialogonplayer("axis_gametype");
    else if(!self issplitscreenplayer() || self issplitscreenplayerprimary()) {
      _id_FFA7278C9FEEBDF2 = 1;

      if(scripts\mp\utility\game::getgametype() == "arena") {
        if(isDefined(game["roundsPlayed"]) && game["roundsPlayed"] == 0)
          _id_FFA7278C9FEEBDF2 = 1;
        else if(shouldplayarenaintro() || isDefined(game["roundsPlayed"]) && game["roundsPlayed"] % 2 == 0) {
          _id_FFA7278C9FEEBDF2 = 0;

          if(game["matchPoint"] != 1 && game["finalRound"] != 1) {
            if(game["roundsPlayed"] % 6 == 0) {
              game["dialog"]["offense_obj"] = "boost_genericround";
              game["dialog"]["defense_obj"] = "boost_genericround";
            }
          }

          if(self.team == game["attackers"]) {
            if(!self issplitscreenplayer() || self issplitscreenplayerprimary())
              scripts\mp\utility\dialog::leaderdialogonplayer("offense_obj", "introboost");
          } else if(!self issplitscreenplayer() || self issplitscreenplayerprimary())
            scripts\mp\utility\dialog::leaderdialogonplayer("defense_obj", "introboost");
        } else
          _id_FFA7278C9FEEBDF2 = 0;
      }

      if(_id_FFA7278C9FEEBDF2)
        scripts\mp\utility\dialog::leaderdialogonplayer("gametype", "gametype");
    }
  }

  scripts\mp\flags::gameflagwait("prematch_done");
  waitframe();

  if(istrue(level._id_AAEE655630513B9D))
    wait 3.5;

  if(scripts\mp\utility\game::getgametype() == "arena") {
    if(isDefined(game["roundsPlayed"]) && game["roundsPlayed"] == 0) {
      if(self.team == game["attackers"]) {
        if(!self issplitscreenplayer() || self issplitscreenplayerprimary())
          scripts\mp\utility\dialog::leaderdialogonplayer("offense_obj", "introboost");
      } else if(!self issplitscreenplayer() || self issplitscreenplayerprimary())
        scripts\mp\utility\dialog::leaderdialogonplayer("defense_obj", "introboost");
    }
  } else if(self.team == game["attackers"]) {
    if(!self issplitscreenplayer() || self issplitscreenplayerprimary())
      scripts\mp\utility\dialog::leaderdialogonplayer("offense_obj", "introboost");
  } else if(!self issplitscreenplayer() || self issplitscreenplayerprimary())
    scripts\mp\utility\dialog::leaderdialogonplayer("defense_obj", "introboost");
}

_id_03AA69E0E6827CE5() {
  if(!isPlayer(self)) {
    return;
  }
  if(isDefined(self.team) && self.team != "spectator") {
    _id_A72551FF1C8F8278 = [];
    _id_A72551FF1C8F8278[_id_A72551FF1C8F8278.size] = "mp_infil_mix_musicheavy";
    _id_A72551FF1C8F8278[_id_A72551FF1C8F8278.size] = "mp_infil_mix_normal";
    _id_2AB153106AB328F7 = _id_A72551FF1C8F8278.size;
    _id_D019BE313DBA7991 = randomint(_id_2AB153106AB328F7);
    self._id_5B097BDE4417D7AD = _id_A72551FF1C8F8278[_id_D019BE313DBA7991];

    if(isDefined(self._id_ACFBB9CAED7125F9) && self._id_ACFBB9CAED7125F9 == 1) {
      if(self.team == "allies") {
        _id_81EF0EBAF8A76116 = game["music"]["west_animated_infil_classic"].size;
        level.cur_infil_track = randomint(_id_81EF0EBAF8A76116);
        self setsoundsubmix(self._id_5B097BDE4417D7AD);
        self setplayermusicstate(game["music"]["west_animated_infil_classic"][level.cur_infil_track]);
        self.playedinfilmusic = 1;
      } else {
        _id_81EF0EBAF8A76116 = game["music"]["east_animated_infil_classic"].size;
        level.cur_infil_track = randomint(_id_81EF0EBAF8A76116);
        self setsoundsubmix(self._id_5B097BDE4417D7AD);
        self setplayermusicstate(game["music"]["east_animated_infil_classic"][level.cur_infil_track]);
        self.playedinfilmusic = 1;
      }
    } else if(self.team == "allies") {
      _id_81EF0EBAF8A76116 = game["music"]["west_animated_infil"].size;
      level.cur_infil_track = randomint(_id_81EF0EBAF8A76116);
      self setsoundsubmix(self._id_5B097BDE4417D7AD);
      self setplayermusicstate(game["music"]["west_animated_infil"][level.cur_infil_track]);
      self.playedinfilmusic = 1;
    } else {
      _id_81EF0EBAF8A76116 = game["music"]["east_animated_infil"].size;
      level.cur_infil_track = randomint(_id_81EF0EBAF8A76116);
      self setsoundsubmix(self._id_5B097BDE4417D7AD);
      self setplayermusicstate(game["music"]["east_animated_infil"][level.cur_infil_track]);
      self.playedinfilmusic = 1;
    }
  }
}

_id_99EBE915CE92EB6F() {
  self endon("disconnect");

  if(scripts\mp\flags::gameflag("prematch_done")) {
    return;
  }
  level waittill("prematch_music");

  if(!level.splitscreen && !isDefined(self.playedinfilmusic) || level.splitscreen && !isDefined(level.playedstartingmusic)) {
    if(!self issplitscreenplayer() || self issplitscreenplayerprimary()) {
      if(isDefined(self.team) && self.team != "spectator" && scripts\mp\utility\game::getgametype() != "arm" && scripts\mp\utility\game::getgametype() != "arena" && scripts\mp\utility\game::getgametype() != "conflict" && !scripts\mp\utility\game::isroundbased()) {
        mapname = getDvar("g_mapname");

        if(mapname == "mp_gunsmith_gl")
          self setplayermusicstate("");
        else if(scripts\mp\utility\game::getgametype() == "ballmode") {
          if(isDefined(game["roundsPlayed"]) && game["roundsPlayed"] == 0) {
            if(self.team == "allies") {
              if(ismusicenabled()) {
                if(isDefined(self._id_ACFBB9CAED7125F9) && self._id_ACFBB9CAED7125F9 == 1) {
                  _id_39D6886350FA21AB = _id_7AB5B649FA408138::_id_17EE301CF0B5BA85("spawn_allies_classic");
                  self setplayermusicstate(_id_39D6886350FA21AB);
                } else {
                  _id_39D6886350FA21AB = _id_7AB5B649FA408138::_id_17EE301CF0B5BA85("spawn_allies");
                  self setplayermusicstate(_id_39D6886350FA21AB);
                }
              }

              self.nosuspensemusic = 1;
            } else {
              if(ismusicenabled()) {
                if(isDefined(self._id_ACFBB9CAED7125F9) && self._id_ACFBB9CAED7125F9 == 1) {
                  _id_B41695C9593199E8 = _id_7AB5B649FA408138::_id_17EE301CF0B5BA85("spawn_axis_classic");
                  self setplayermusicstate(_id_B41695C9593199E8);
                } else {
                  _id_B41695C9593199E8 = _id_7AB5B649FA408138::_id_17EE301CF0B5BA85("spawn_axis");
                  self setplayermusicstate(_id_B41695C9593199E8);
                }
              }

              self.nosuspensemusic = 1;
            }
          }
        } else if(self.team == "allies") {
          if(ismusicenabled()) {
            if(isDefined(self._id_ACFBB9CAED7125F9) && self._id_ACFBB9CAED7125F9 == 1) {
              _id_39D6886350FA21AB = _id_7AB5B649FA408138::_id_17EE301CF0B5BA85("spawn_allies_classic");
              self setplayermusicstate(_id_39D6886350FA21AB);
            } else {
              _id_39D6886350FA21AB = _id_7AB5B649FA408138::_id_17EE301CF0B5BA85("spawn_allies");
              self setplayermusicstate(_id_39D6886350FA21AB);
            }
          }

          self.nosuspensemusic = 1;
        } else {
          if(ismusicenabled()) {
            if(isDefined(self._id_ACFBB9CAED7125F9) && self._id_ACFBB9CAED7125F9 == 1) {
              _id_B41695C9593199E8 = _id_7AB5B649FA408138::_id_17EE301CF0B5BA85("spawn_axis_classic");
              self setplayermusicstate(_id_B41695C9593199E8);
            } else {
              _id_B41695C9593199E8 = _id_7AB5B649FA408138::_id_17EE301CF0B5BA85("spawn_axis");
              self setplayermusicstate(_id_B41695C9593199E8);
            }
          }

          self.nosuspensemusic = 1;
        }
      }

      if(scripts\mp\utility\game::getgametype() == "arena" && isDefined(game["roundsPlayed"]) && game["roundsPlayed"] == 0) {
        if(isDefined(self._id_ACFBB9CAED7125F9) && self._id_ACFBB9CAED7125F9 == 1) {
          _id_C5928F7E9D1E509D = _id_7AB5B649FA408138::_id_17EE301CF0B5BA85("gunfight_spawn_classic");
          self setplayermusicstate(_id_C5928F7E9D1E509D);
        } else {
          _id_C5928F7E9D1E509D = _id_7AB5B649FA408138::_id_17EE301CF0B5BA85("gunfight_spawn");
          self setplayermusicstate(_id_C5928F7E9D1E509D);
        }
      } else if(scripts\mp\utility\game::isroundbased() && isDefined(game["roundsPlayed"]) && game["roundsPlayed"] == 0) {
        if(self.team == "allies") {
          if(ismusicenabled()) {
            if(isDefined(self._id_ACFBB9CAED7125F9) && self._id_ACFBB9CAED7125F9 == 1) {
              _id_39D6886350FA21AB = _id_7AB5B649FA408138::_id_17EE301CF0B5BA85("spawn_allies_classic");
              self setplayermusicstate(_id_39D6886350FA21AB);
            } else {
              _id_39D6886350FA21AB = _id_7AB5B649FA408138::_id_17EE301CF0B5BA85("spawn_allies");
              self setplayermusicstate(_id_39D6886350FA21AB);
            }
          }

          self.nosuspensemusic = 1;
        } else {
          if(ismusicenabled()) {
            if(isDefined(self._id_ACFBB9CAED7125F9) && self._id_ACFBB9CAED7125F9 == 1) {
              _id_B41695C9593199E8 = _id_7AB5B649FA408138::_id_17EE301CF0B5BA85("spawn_axis_classic");
              self setplayermusicstate(_id_B41695C9593199E8);
            } else {
              _id_B41695C9593199E8 = _id_7AB5B649FA408138::_id_17EE301CF0B5BA85("spawn_axis");
              self setplayermusicstate(_id_B41695C9593199E8);
            }
          }

          self.nosuspensemusic = 1;
        }
      }

      if((scripts\mp\utility\game::getgametype() == "arm" || scripts\mp\utility\game::getgametype() == "conflict") && !isDefined(level.playedstartingmusic)) {
        if(self.team == "allies") {
          if(ismusicenabled()) {
            if(isDefined(self._id_ACFBB9CAED7125F9) && self._id_ACFBB9CAED7125F9 == 1) {
              _id_39D6886350FA21AB = _id_7AB5B649FA408138::_id_17EE301CF0B5BA85("spawn_allies_classic");
              self setplayermusicstate(_id_39D6886350FA21AB);
            } else {
              _id_39D6886350FA21AB = _id_7AB5B649FA408138::_id_17EE301CF0B5BA85("spawn_allies");
              self setplayermusicstate(_id_39D6886350FA21AB);
            }
          }

          self.nosuspensemusic = 1;
        } else {
          if(ismusicenabled()) {
            if(isDefined(self._id_ACFBB9CAED7125F9) && self._id_ACFBB9CAED7125F9 == 1) {
              _id_B41695C9593199E8 = _id_7AB5B649FA408138::_id_17EE301CF0B5BA85("spawn_axis_classic");
              self setplayermusicstate(_id_B41695C9593199E8);
            } else {
              _id_B41695C9593199E8 = _id_7AB5B649FA408138::_id_17EE301CF0B5BA85("spawn_axis");
              self setplayermusicstate(_id_B41695C9593199E8);
            }
          }

          self.nosuspensemusic = 1;
        }
      }
    }

    if(level.splitscreen)
      level.playedstartingmusic = 1;

    thread suspensemusic_reset(20);
  }
}

shouldplayarenaintro() {
  if(scripts\mp\utility\game::iswinbytworulegametype())
    return 0;

  if(game["finalRound"] == 1) {
    game["dialog"]["offense_obj"] = "boost_tied_matchpoint";
    game["dialog"]["defense_obj"] = "boost_tied_matchpoint";
    return 1;
  } else if(game["matchPoint"] == 1) {
    _id_10BA24A48F1B3F6D = "";

    foreach(_id_F90358454413407F in level.teamnamelist) {
      _id_C077C467A67F3354 = scripts\mp\utility\game::getroundswon(_id_F90358454413407F);

      if(_id_C077C467A67F3354 == level.winlimit - 1) {
        _id_10BA24A48F1B3F6D = _id_F90358454413407F;
        break;
      }
    }

    if(game["attackers"] == _id_10BA24A48F1B3F6D) {
      game["dialog"]["offense_obj"] = "boost_winning_matchpoint";
      game["dialog"]["defense_obj"] = "boost_losing_matchpoint";
    } else {
      game["dialog"]["offense_obj"] = "boost_losing_matchpoint";
      game["dialog"]["defense_obj"] = "boost_winning_matchpoint";
    }

    return 1;
  }

  return 0;
}

watchhostmigration() {
  self endon("disconnect");
  level endon("grace_period_ending");

  for(;;) {
    level waittill("host_migration_begin");
    _id_70FB9C790A2BB63D = level.ingraceperiod;
    level waittill("host_migration_end");

    if(_id_70FB9C790A2BB63D)
      thread dointro();
  }
}

onlastalive() {
  level endon("game_ended");
  level waittill("last_alive", player);

  if(!isalive(player)) {
    return;
  }
  if(scripts\mp\utility\game::getgametype() == "siege") {
    player scripts\mp\utility\dialog::leaderdialogonplayer("siege_lastalive_zones");
    level thread onlastalive();
    return;
  } else if(scripts\mp\utility\game::getgametype() == "sr" && !level.nofriendlytags) {
    player scripts\mp\utility\dialog::leaderdialogonplayer("lastalive_revive");
    level thread onlastalive();
    return;
  }

  if(!_id_1F97A44D1761C919::_id_D87D5DEB069BF8E5("player_last_man_standing", player))
    player scripts\mp\utility\dialog::leaderdialogonplayer("last_alive");
}

onroundswitch() {
  level waittill("round_switch", _id_90DDDF3DEA480715);

  switch (_id_90DDDF3DEA480715) {
    case "halftime":
      foreach(player in level.players) {
        if(player issplitscreenplayer() && !player issplitscreenplayerprimary()) {
          continue;
        }
        player scripts\mp\utility\dialog::leaderdialogonplayer("halftime");
      }

      break;
    case "overtime":
      foreach(player in level.players) {
        if(player issplitscreenplayer() && !player issplitscreenplayerprimary()) {
          continue;
        }
        player scripts\mp\utility\dialog::leaderdialogonplayer("overtime");
      }

      break;
    default:
      if(istrue(level.switchedsides)) {
        foreach(player in level.players) {
          if(player issplitscreenplayer() && !player issplitscreenplayerprimary()) {
            continue;
          }
          player scripts\mp\utility\dialog::leaderdialogonplayer("side_switch");
        }

        break;
        return;
      }
  }
}

plunder_endgame_music() {
  if(isDefined(level.endmusicplayed)) {
    return;
  }
  game["music"]["payback_lose"] = [];
  game["music"]["payback_lose"][game["music"]["payback_lose"].size] = "mp_lose_1";
  game["music"]["payback_lose"][game["music"]["payback_lose"].size] = "mp_draw_1";
  game["music"]["payback_lose"][game["music"]["payback_lose"].size] = "mp_lose_2";
  game["music"]["payback_lose"][game["music"]["payback_lose"].size] = "mp_draw_1";
  game["music"]["payback_win"] = [];
  game["music"]["payback_win"][game["music"]["payback_win"].size] = "mp_win_1";
  game["music"]["payback_win"][game["music"]["payback_win"].size] = "mp_win_2";
  _id_C3E10A42A81ADE25 = scripts\mp\gamescore::getteamscoreplacements();
  level.endmusicplayed = 1;

  foreach(player in level.players) {
    placement = _id_C3E10A42A81ADE25[player.team];

    if(placement <= 10) {
      _id_2E159BB14AEA95A7 = _id_7AB5B649FA408138::_id_17EE301CF0B5BA85("payback_win");
      player setplayermusicstate(_id_2E159BB14AEA95A7);
    } else {
      _id_C23F3CF75DD0E292 = _id_7AB5B649FA408138::_id_17EE301CF0B5BA85("payback_lose");
      player setplayermusicstate(_id_C23F3CF75DD0E292);
    }

    player setsoundsubmix("mp_matchend_music", 2);
    player enableplayerbreathsystem(0);
  }
}

_id_D63C781D5E272B07(players) {
  _id_D63C781D5E272B07 = _id_7AB5B649FA408138::_id_17EE301CF0B5BA85("dmz_activity_start");
  _id_BE1CA81FC3DCCCD8 = _id_7AB5B649FA408138::_id_17EE301CF0B5BA85("dmz_activity_start_classic");
  _id_7AB5B649FA408138::_id_FE75A89529DD0FD0(players, _id_D63C781D5E272B07, undefined, undefined, _id_BE1CA81FC3DCCCD8);
}

_id_DCEA6768454F7075(players) {
  _id_DCEA6768454F7075 = _id_7AB5B649FA408138::_id_17EE301CF0B5BA85("dmz_activity_tension");
  _id_A55DBF4A91704962 = _id_7AB5B649FA408138::_id_17EE301CF0B5BA85("dmz_activity_tension_classic");
  _id_7AB5B649FA408138::_id_FE75A89529DD0FD0(players, _id_DCEA6768454F7075, undefined, undefined, _id_A55DBF4A91704962);
}

_id_39A3BA69D3B190A5(players) {
  _id_A6A9A86B34886947 = _id_7AB5B649FA408138::_id_17EE301CF0B5BA85("dmz_activity_action");
  _id_94A7A4AC93C16E18 = _id_7AB5B649FA408138::_id_17EE301CF0B5BA85("dmz_activity_action_classic");
  _id_7AB5B649FA408138::_id_FE75A89529DD0FD0(players, _id_A6A9A86B34886947, undefined, undefined, _id_94A7A4AC93C16E18);
}

_id_F139A00330157E01(players) {
  _id_F139A00330157E01 = _id_7AB5B649FA408138::_id_17EE301CF0B5BA85("dmz_activity_win");
  _id_EAED847B415CDE8E = _id_7AB5B649FA408138::_id_17EE301CF0B5BA85("dmz_activity_win_classic");
  _id_7AB5B649FA408138::_id_FE75A89529DD0FD0(players, _id_F139A00330157E01, undefined, undefined, _id_EAED847B415CDE8E);
}

_id_4FE255A72526EA50(players) {
  _id_4FE255A72526EA50 = _id_7AB5B649FA408138::_id_17EE301CF0B5BA85("dmz_activity_lose");
  _id_DC3CC4C96276713B = _id_7AB5B649FA408138::_id_17EE301CF0B5BA85("dmz_activity_lose_classic");
  _id_7AB5B649FA408138::_id_FE75A89529DD0FD0(players, _id_4FE255A72526EA50, undefined, undefined, _id_DC3CC4C96276713B);
}

ongameended() {
  level thread roundwinnerdialog();
  level thread gamewinnerdialog();
  level waittill("start_game_win_audio", winner);

  if(!isDefined(winner) || isDefined(level.endmusicplayed)) {
    return;
  }
  if(scripts\cp_mp\utility\game_utility::_id_0BEFF479639E6508() && scripts\mp\utility\game::getsubgametype() != "plunder" && scripts\mp\utility\game::getsubgametype() != "risk" && scripts\mp\utility\game::getsubgametype() != "rumble_mgl") {
    return;
  }
  if(level.teambased) {
    if(level.splitscreen) {
      if(winner == "allies") {
        foreach(player in level.players) {
          if(player issplitscreenplayer() && !player issplitscreenplayerprimary()) {
            continue;
          }
          player clearsoundsubmix("deaths_door_mp");

          if(isDefined(player._id_ACFBB9CAED7125F9) && player._id_ACFBB9CAED7125F9 == 1)
            player setplayermusicstate(game["music"]["victory_allies_classic"]);
          else
            player setplayermusicstate(game["music"]["victory_allies"]);

          player setsoundsubmix("mp_matchend_music", 2);
        }
      } else if(winner == "axis") {
        foreach(player in level.players) {
          if(player issplitscreenplayer() && !player issplitscreenplayerprimary()) {
            continue;
          }
          player clearsoundsubmix("deaths_door_mp");

          if(isDefined(player._id_ACFBB9CAED7125F9) && player._id_ACFBB9CAED7125F9 == 1)
            player setplayermusicstate(game["music"]["victory_axis_classic"]);
          else
            player setplayermusicstate(game["music"]["victory_axis"]);

          player setsoundsubmix("mp_matchend_music", 2);
        }
      } else {
        foreach(player in level.players) {
          player clearsoundsubmix("deaths_door_mp");

          if(isDefined(player._id_ACFBB9CAED7125F9) && player._id_ACFBB9CAED7125F9 == 1)
            player setplayermusicstate(game["music"]["victory_allies_classic"]);
          else
            player setplayermusicstate(game["music"]["victory_allies"]);

          player setsoundsubmix("mp_matchend_music", 2);
        }
      }
    } else if(winner == "allies") {
      foreach(player in level.players) {
        player clearsoundsubmix("deaths_door_mp");
        player setsoundsubmix("mp_matchend_music", 2);

        if(isDefined(player._id_ACFBB9CAED7125F9) && player._id_ACFBB9CAED7125F9 == 1) {
          if(isDefined(player.team) && player.team == "allies")
            player setplayermusicstate(game["music"]["victory_allies_classic"]);
          else
            player setplayermusicstate(game["music"]["defeat_axis_classic"]);

          continue;
        }

        if(isDefined(player.team) && player.team == "allies") {
          player setplayermusicstate(game["music"]["victory_allies"]);
          continue;
        }

        player setplayermusicstate(game["music"]["defeat_axis"]);
      }
    } else if(winner == "axis") {
      foreach(player in level.players) {
        player clearsoundsubmix("deaths_door_mp");
        player setsoundsubmix("mp_matchend_music", 2);

        if(isDefined(player._id_ACFBB9CAED7125F9) && player._id_ACFBB9CAED7125F9 == 1) {
          if(isDefined(player.team) && player.team == "axis")
            player setplayermusicstate(game["music"]["victory_axis_classic"]);
          else
            player setplayermusicstate(game["music"]["defeat_allies_classic"]);

          continue;
        }

        if(isDefined(player.team) && player.team == "axis") {
          player setplayermusicstate(game["music"]["victory_axis"]);
          continue;
        }

        player setplayermusicstate(game["music"]["defeat_allies"]);
      }
    } else {
      foreach(player in level.players) {
        player clearsoundsubmix("deaths_door_mp");
        player setsoundsubmix("mp_matchend_music", 2);

        if(isDefined(player._id_ACFBB9CAED7125F9) && player._id_ACFBB9CAED7125F9 == 1) {
          if(isDefined(player.team) && player.team == "allies")
            player setplayermusicstate(game["music"]["draw_allies_classic"]);
          else
            player setplayermusicstate(game["music"]["draw_axis_classic"]);

          continue;
        }

        if(isDefined(player.team) && player.team == "allies") {
          player setplayermusicstate(game["music"]["draw_allies"]);
          continue;
        }

        player setplayermusicstate(game["music"]["draw_axis"]);
      }
    }
  } else {
    foreach(player in level.players) {
      player clearsoundsubmix("deaths_door_mp");
      player setsoundsubmix("mp_matchend_music", 2);
      player setplayermusicstate("");

      if(player issplitscreenplayer() && !player issplitscreenplayerprimary()) {
        continue;
      }
      if(isDefined(player._id_ACFBB9CAED7125F9) && player._id_ACFBB9CAED7125F9 == 1) {
        if(player.pers["team"] != "allies" && player.pers["team"] != "axis")
          player setplayermusicstate(game["music"]["victory_allies_classic"]);
        else if(isDefined(winner) && isPlayer(winner) && player == winner)
          player setplayermusicstate(game["music"]["victory_" + player.pers["team"] + "_classic"]);
        else if(!level.splitscreen)
          player setplayermusicstate(game["music"]["defeat_" + player.pers["team"] + "_classic"]);

        continue;
      }

      if(player.pers["team"] != "allies" && player.pers["team"] != "axis") {
        player setplayermusicstate(game["music"]["victory_allies"]);
        continue;
      }

      if(isDefined(winner) && isPlayer(winner) && player == winner) {
        player setplayermusicstate(game["music"]["victory_" + player.pers["team"]]);
        continue;
      }

      if(!level.splitscreen)
        player setplayermusicstate(game["music"]["defeat_" + player.pers["team"]]);
    }
  }

  level.endmusicplayed = 1;
}

midpoint_music(_id_0AA81B2C7E0A29A1) {
  thread stopsuspensemusic();

  foreach(player in level.players) {
    if(player.team == _id_0AA81B2C7E0A29A1) {
      _id_E13DA16D3D6BC87E = _id_7AB5B649FA408138::_id_17EE301CF0B5BA85("midpoint_winning");
      player setplayermusicstate(_id_E13DA16D3D6BC87E);
      continue;
    }

    _id_894F38A130343410 = _id_7AB5B649FA408138::_id_17EE301CF0B5BA85("midpoint_losing");
    player setplayermusicstate(_id_894F38A130343410);
  }

  wait 25;
  thread suspensemusic();
}

dominating_music(_id_8B9B442335D5C181) {
  if(isDefined(level.dominating_music) && level.dominating_music == 1) {
    return;
  }
  thread stopsuspensemusic();

  if(_id_8B9B442335D5C181 == "axis") {
    foreach(player in level.players) {
      if(player.team == "allies") {
        _id_5E23D83C64A2C857 = _id_7AB5B649FA408138::_id_17EE301CF0B5BA85("dominated_allies");
        player setplayermusicstate(_id_5E23D83C64A2C857);
        continue;
      }

      _id_77162852713D34B9 = _id_7AB5B649FA408138::_id_17EE301CF0B5BA85("dominating_axis");
      player setplayermusicstate(_id_77162852713D34B9);
    }
  } else {
    foreach(player in level.players) {
      if(isDefined(player._id_ACFBB9CAED7125F9) && player._id_ACFBB9CAED7125F9 == 1) {
        if(player.team == "allies") {
          _id_7B072BE2D819130E = _id_7AB5B649FA408138::_id_17EE301CF0B5BA85("dominating_allies_classic");
          player setplayermusicstate(_id_7B072BE2D819130E);
        } else {
          _id_E8C7CF1D8FD6FFDC = _id_7AB5B649FA408138::_id_17EE301CF0B5BA85("dominated_axis_classic");
          player setplayermusicstate(_id_E8C7CF1D8FD6FFDC);
        }

        continue;
      }

      if(player.team == "allies") {
        _id_7B072BE2D819130E = _id_7AB5B649FA408138::_id_17EE301CF0B5BA85("dominating_allies");
        player setplayermusicstate(_id_7B072BE2D819130E);
        continue;
      }

      _id_E8C7CF1D8FD6FFDC = _id_7AB5B649FA408138::_id_17EE301CF0B5BA85("dominated_axis");
      player setplayermusicstate(_id_E8C7CF1D8FD6FFDC);
    }
  }

  level.dominating_music = 1;
  wait 25;
  level.dominating_music = 0;
  thread suspensemusic();
}

bombplanted_music() {
  if(isDefined(level.bombtimer) && level.bombtimer > 44) {
    waittime = level.bombtimer - 45;
    wait(waittime);

    foreach(player in level.players) {
      if(isDefined(player._id_ACFBB9CAED7125F9) && player._id_ACFBB9CAED7125F9 == 1) {
        _id_552EC565648D80DA = _id_7AB5B649FA408138::_id_17EE301CF0B5BA85("bombplant_classic");
        player setplayermusicstate(_id_552EC565648D80DA);
        continue;
      }

      _id_552EC565648D80DA = _id_7AB5B649FA408138::_id_17EE301CF0B5BA85("bombplant");
      player setplayermusicstate(_id_552EC565648D80DA);
    }
  } else if(isDefined(level.bombtimer)) {
    waittime = level.bombtimer - 30;

    if(waittime < 0)
      waittime = 0;

    wait(waittime);

    foreach(player in level.players) {
      if(isDefined(player._id_ACFBB9CAED7125F9) && player._id_ACFBB9CAED7125F9 == 1) {
        _id_BEABA493B37AB4FC = _id_7AB5B649FA408138::_id_17EE301CF0B5BA85("bombplant_30_classic");
        player setplayermusicstate(_id_BEABA493B37AB4FC);
        continue;
      }

      _id_BEABA493B37AB4FC = _id_7AB5B649FA408138::_id_17EE301CF0B5BA85("bombplant_30");
      player setplayermusicstate(_id_BEABA493B37AB4FC);
    }
  }

  level.bombplanted_music = 1;
}

roundwinnerdialog() {
  if(scripts\mp\utility\game::getgametype() == "ballmode") {
    return;
  }
  level waittill("round_win", winner);

  if(istrue(level._id_1242A000845A4331)) {
    return;
  }
  delay = level.roundenddelay / 4;

  if(delay > 0)
    wait(delay);

  _id_43A41488C3C487DF = game["teamScores"]["allies"];
  _id_18A3FAB290E780C2 = game["teamScores"]["axis"];

  if(!isDefined(winner) || isPlayer(winner)) {
    return;
  }
  if(istrue(game["practiceRound"])) {
    game["dialog"]["round_success"] = "gamestate_practice_over";
    game["dialog"]["round_failure"] = "gamestate_practice_over";
    game["dialog"]["round_draw"] = "gamestate_practice_over";
  }

  if(winner == "allies") {
    scripts\mp\utility\dialog::leaderdialog("round_success", "allies");
    scripts\mp\utility\dialog::leaderdialog("round_failure", "axis");
  } else if(winner == "axis") {
    scripts\mp\utility\dialog::leaderdialog("round_success", "axis");
    scripts\mp\utility\dialog::leaderdialog("round_failure", "allies");
  } else if(_id_18A3FAB290E780C2 > _id_43A41488C3C487DF) {
    scripts\mp\utility\dialog::leaderdialog("round_success", "axis");
    scripts\mp\utility\dialog::leaderdialog("round_failure", "allies");
  } else if(_id_43A41488C3C487DF > _id_18A3FAB290E780C2) {
    scripts\mp\utility\dialog::leaderdialog("round_success", "allies");
    scripts\mp\utility\dialog::leaderdialog("round_failure", "axis");
  } else {
    scripts\mp\utility\dialog::leaderdialog("round_draw", "allies");
    scripts\mp\utility\dialog::leaderdialog("round_draw", "axis");
  }
}

gamewinnerdialog() {
  level waittill("start_game_win_audio", winner);
  delay = level.postroundtime / 2;

  if(delay > 0)
    wait(delay);

  if(!isDefined(winner)) {
    return;
  }
  if(scripts\cp_mp\utility\game_utility::_id_0BEFF479639E6508()) {
    return;
  }
  if(isPlayer(winner) && !level.teambased) {
    for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < level.placement["all"].size; _id_AC0E594AC96AA3A8++) {
      player = level.placement["all"][_id_AC0E594AC96AA3A8];

      if(player issplitscreenplayer() && !player issplitscreenplayerprimary()) {
        continue;
      }
      if(_id_AC0E594AC96AA3A8 < 3) {
        player scripts\mp\utility\dialog::leaderdialogonplayer("mission_success");
        continue;
      }

      player scripts\mp\utility\dialog::leaderdialogonplayer("mission_failure");
    }
  } else if(winner == "allies") {
    scripts\mp\utility\dialog::leaderdialog("mission_success", "allies");
    scripts\mp\utility\dialog::leaderdialog("mission_failure", "axis");
  } else if(winner == "axis") {
    scripts\mp\utility\dialog::leaderdialog("mission_success", "axis");
    scripts\mp\utility\dialog::leaderdialog("mission_failure", "allies");
  } else {
    scripts\mp\utility\dialog::leaderdialog("mission_draw", "axis");
    scripts\mp\utility\dialog::leaderdialog("mission_draw", "allies");
  }
}

musiccontroller() {
  level endon("game_ended");

  if(!isDefined(level.musicenabled))
    level.musicenabled = 1;

  thread suspensemusic();

  if(scripts\mp\utility\game::getgametype() == "ballmode") {
    return;
  }
  level waittill("match_ending_soon", _id_401C3A2E68AAB0FD);

  if(level.roundlimit == 1 || game["roundsPlayed"] == level.roundlimit - 1 || scripts\mp\utility\game::ismoddedroundgame()) {
    if(!level.splitscreen) {
      if(_id_401C3A2E68AAB0FD == "time") {
        if(level.teambased) {
          if(game["teamScores"]["allies"] > game["teamScores"]["axis"]) {
            if(ismusicenabled())
              thread timelimitmusic("allies");

            scripts\mp\utility\dialog::leaderdialog("winning_time", "allies");
            scripts\mp\utility\dialog::leaderdialog("losing_time", "axis");
          } else if(game["teamScores"]["axis"] > game["teamScores"]["allies"]) {
            if(ismusicenabled())
              thread timelimitmusic("axis");

            scripts\mp\utility\dialog::leaderdialog("winning_time", "axis");
            scripts\mp\utility\dialog::leaderdialog("losing_time", "allies");
          } else
            thread timelimitmusic("draw");
        } else if(ismusicenabled()) {
          foreach(player in level.players) {
            if(player.team == "allies") {
              _id_809968286B16012E = _id_7AB5B649FA408138::_id_17EE301CF0B5BA85("winning_allies");
              player setplayermusicstate(_id_809968286B16012E);
              continue;
            }

            _id_F1BCFF5BB49B73D9 = _id_7AB5B649FA408138::_id_17EE301CF0B5BA85("winning_axis");
            player setplayermusicstate(_id_F1BCFF5BB49B73D9);
          }
        }
      } else if(_id_401C3A2E68AAB0FD == "score") {
        if(level.teambased && scripts\mp\utility\game::getgametype() != "arena") {
          if(game["teamScores"]["allies"] > game["teamScores"]["axis"]) {
            if(ismusicenabled()) {
              foreach(player in level.players) {
                if(player.team == "allies") {
                  _id_809968286B16012E = _id_7AB5B649FA408138::_id_17EE301CF0B5BA85("winning_allies");
                  player setplayermusicstate(_id_809968286B16012E);
                  continue;
                }

                _id_0B859892416A15F1 = _id_7AB5B649FA408138::_id_17EE301CF0B5BA85("losing_axis");
                player setplayermusicstate(_id_0B859892416A15F1);
              }
            }

            scripts\mp\utility\dialog::leaderdialog("winning_score", "allies");
            scripts\mp\utility\dialog::leaderdialog("losing_score", "axis");
          } else if(game["teamScores"]["axis"] > game["teamScores"]["allies"]) {
            if(ismusicenabled()) {
              foreach(player in level.players) {
                if(player.team == "allies") {
                  _id_83EB6DB3E01FA1B6 = _id_7AB5B649FA408138::_id_17EE301CF0B5BA85("losing_allies");
                  player setplayermusicstate(_id_83EB6DB3E01FA1B6);
                  continue;
                }

                _id_F1BCFF5BB49B73D9 = _id_7AB5B649FA408138::_id_17EE301CF0B5BA85("winning_axis");
                player setplayermusicstate(_id_F1BCFF5BB49B73D9);
              }
            }

            scripts\mp\utility\dialog::leaderdialog("winning_score", "axis");
            scripts\mp\utility\dialog::leaderdialog("losing_score", "allies");
          }
        } else {
          _id_6DD753ADD7D1C236 = scripts\mp\gamescore::gethighestscoringplayer();
          _id_15030F107E796007 = scripts\mp\gamescore::getlosingplayers();
          _id_21D6D994B0F4FAF1[0] = _id_6DD753ADD7D1C236;

          if(ismusicenabled()) {
            _id_22139E5490E8792B = "winning_" + _id_6DD753ADD7D1C236.pers["team"];
            _id_0AA81B2C7E0A29A1 = _id_7AB5B649FA408138::_id_17EE301CF0B5BA85(_id_22139E5490E8792B);
            _id_6DD753ADD7D1C236 setplayermusicstate(_id_0AA81B2C7E0A29A1);

            foreach(_id_6EE5484560EC747C in level.players) {
              if(_id_6EE5484560EC747C == _id_6DD753ADD7D1C236) {
                continue;
              }
              _id_1082ADFE62B2F523 = "losing_" + _id_6EE5484560EC747C.pers["team"];
              _id_845734590BB29DA9 = _id_7AB5B649FA408138::_id_17EE301CF0B5BA85(_id_1082ADFE62B2F523);
              _id_6EE5484560EC747C setplayermusicstate(_id_845734590BB29DA9);
            }
          }

          _id_6DD753ADD7D1C236 scripts\mp\utility\dialog::leaderdialogonplayer("winning_score");
          scripts\mp\utility\dialog::leaderdialogonplayers("losing_score", _id_15030F107E796007);
        }
      }
    }
  } else if(scripts\mp\utility\game::getgametype() != "arena")
    _func_6F9B54CEA87F1C9E();
}

matchendingsoonleaderdialog(dialog, _id_F8912399577F51CA) {
  if(scripts\mp\utility\game::getgametype() == "arena") {
    if(isDefined(_id_F8912399577F51CA) && !isDefined(level.notifiedtimesup) && _id_F8912399577F51CA <= 10) {
      level.notifiedtimesup = 1;
      dialog = "timesup_ten";
    } else if(istrue(game["isLaunchChunk"])) {
      if(game["launchChunkRuleSet"] == 1 || game["launchChunkRuleSet"] == 2)
        return 0;
    } else
      return 0;
  }

  if(level.teambased) {
    foreach(team in level.teamnamelist) {
      if(team != "spectator")
        scripts\mp\utility\dialog::leaderdialog(dialog, team);
    }
  } else {
    players = [];

    foreach(_id_AC0E424AC96A7113 in level.players) {
      if(_id_AC0E424AC96A7113.team != "spectator")
        players[players.size] = _id_AC0E424AC96A7113;
    }

    scripts\mp\utility\dialog::leaderdialogonplayers(dialog, players);
  }

  return 1;
}

timelimitmusic(team) {
  self endon("game_ended");
  level notify("stop_suspense_music");

  if(scripts\mp\utility\game::getgametype() != "arena") {
    if(team == "allies") {
      foreach(player in level.players) {
        if(player.team == "allies") {
          _id_809968286B16012E = _id_7AB5B649FA408138::_id_17EE301CF0B5BA85("winning_allies");
          player setplayermusicstate(_id_809968286B16012E);
          continue;
        }

        _id_0B859892416A15F1 = _id_7AB5B649FA408138::_id_17EE301CF0B5BA85("losing_axis");
        player setplayermusicstate(_id_0B859892416A15F1);
      }
    } else if(team == "axis") {
      foreach(player in level.players) {
        if(player.team == "allies") {
          _id_83EB6DB3E01FA1B6 = _id_7AB5B649FA408138::_id_17EE301CF0B5BA85("losing_allies");
          player setplayermusicstate(_id_83EB6DB3E01FA1B6);
          continue;
        }

        _id_F1BCFF5BB49B73D9 = _id_7AB5B649FA408138::_id_17EE301CF0B5BA85("winning_axis");
        player setplayermusicstate(_id_F1BCFF5BB49B73D9);
      }
    } else {
      foreach(player in level.players) {
        if(player.team == "allies") {
          _id_83EB6DB3E01FA1B6 = _id_7AB5B649FA408138::_id_17EE301CF0B5BA85("losing_allies");
          player setplayermusicstate(_id_83EB6DB3E01FA1B6);
          continue;
        }

        _id_0B859892416A15F1 = _id_7AB5B649FA408138::_id_17EE301CF0B5BA85("losing_axis");
        player setplayermusicstate(_id_0B859892416A15F1);
      }
    }
  }
}

headquarters_newhq_music() {
  foreach(player in level.players) {
    if(isDefined(player._id_ACFBB9CAED7125F9) && player._id_ACFBB9CAED7125F9 == 1) {
      _id_1727D0AC1471DA03 = _id_7AB5B649FA408138::_id_17EE301CF0B5BA85("hq_new_classic");
      player setplayermusicstate(_id_1727D0AC1471DA03);
      continue;
    }

    _id_1727D0AC1471DA03 = _id_7AB5B649FA408138::_id_17EE301CF0B5BA85("hq_new");
    player setplayermusicstate(_id_1727D0AC1471DA03);
  }
}

headquarters_captured_music() {
  level endon("hq_music_done");

  if(scripts\mp\utility\game::getgametype() == "hq") {
    foreach(player in level.players) {
      if(isDefined(player._id_ACFBB9CAED7125F9) && player._id_ACFBB9CAED7125F9 == 1) {
        _id_611D2B9DA9EDEA1D = _id_7AB5B649FA408138::_id_17EE301CF0B5BA85("hq_captured_classic");
        player setplayermusicstate(_id_611D2B9DA9EDEA1D);
        continue;
      }

      _id_611D2B9DA9EDEA1D = _id_7AB5B649FA408138::_id_17EE301CF0B5BA85("hq_captured");
      player setplayermusicstate(_id_611D2B9DA9EDEA1D);
    }

    level.hq_captured_music = 1;
    wait 60;
    level.hq_captured_music = 0;
  }
}

headquarters_deactivate_music(claimteam) {
  if(istrue(level.hq_captured_music)) {
    level notify("hq_music_done");
    level.hq_captured_music = 0;

    foreach(player in level.players) {
      if(isDefined(player._id_ACFBB9CAED7125F9) && player._id_ACFBB9CAED7125F9 == 1) {
        if(isDefined(player.team)) {
          team = player.team;

          if(team == claimteam) {
            _id_02F4D95AB8379C4F = _id_7AB5B649FA408138::_id_17EE301CF0B5BA85("hq_destroyed_pos_classic");
            player setplayermusicstate(_id_02F4D95AB8379C4F);
          } else {
            _id_4FE7F7597961AB1F = _id_7AB5B649FA408138::_id_17EE301CF0B5BA85("hq_destroyed_neg_classic");
            player setplayermusicstate(_id_4FE7F7597961AB1F);
          }
        }

        continue;
      }

      if(isDefined(player.team)) {
        team = player.team;

        if(team == claimteam) {
          _id_02F4D95AB8379C4F = _id_7AB5B649FA408138::_id_17EE301CF0B5BA85("hq_destroyed_pos");
          player setplayermusicstate(_id_02F4D95AB8379C4F);
        } else {
          _id_4FE7F7597961AB1F = _id_7AB5B649FA408138::_id_17EE301CF0B5BA85("hq_destroyed_neg");
          player setplayermusicstate(_id_4FE7F7597961AB1F);
        }
      }
    }
  }
}

infected_music() {
  _id_CACEB3FF609E8C65 = _id_7AB5B649FA408138::_id_17EE301CF0B5BA85("infected");
  self setplayermusicstate(_id_CACEB3FF609E8C65);
}

_id_5407F73C49740FC7() {}

suspensemusic(_id_8C71E0347DB7824D) {
  if(!ismusicenabled()) {
    return;
  }
  if(scripts\mp\utility\game::getsubgametype() == "dmz")
    thread _id_231DD20BC5A6BD68();

  if(istrue(level.nosuspensemusic)) {
    return;
  }
  mapname = getDvar("g_mapname");

  if(mapname == "mp_gunsmith_gl") {
    return;
  }
  level endon("game_ended");
  level endon("match_ending_soon");
  level endon("stop_suspense_music");
  level.cursuspsensetrack = [];
  level.cursuspsensetrack["allies"] = _id_7AB5B649FA408138::_id_17EE301CF0B5BA85("allies_suspense");
  level.cursuspsensetrack["axis"] = _id_7AB5B649FA408138::_id_17EE301CF0B5BA85("axis_suspense");

  if(isDefined(_id_8C71E0347DB7824D) && _id_8C71E0347DB7824D)
    wait 120;

  for(;;) {
    wait(randomfloatrange(75, 120));

    if(isDefined(level.nosuspensemusic) && level.nosuspensemusic) {
      return;
    }
    if(!istrue(game["inLiveLobby"])) {
      foreach(player in level.players) {
        if(isDefined(player._id_ACFBB9CAED7125F9) && player._id_ACFBB9CAED7125F9 == 1) {
          level.cursuspsensetrack["allies"] = _id_7AB5B649FA408138::_id_17EE301CF0B5BA85("allies_suspense_classic");
          level.cursuspsensetrack["axis"] = _id_7AB5B649FA408138::_id_17EE301CF0B5BA85("axis_suspense_classic");
        } else {
          level.cursuspsensetrack["allies"] = _id_7AB5B649FA408138::_id_17EE301CF0B5BA85("allies_suspense");
          level.cursuspsensetrack["axis"] = _id_7AB5B649FA408138::_id_17EE301CF0B5BA85("axis_suspense");
        }

        if(!isDefined(player.nosuspensemusic)) {
          if(isDefined(player.team)) {
            team = player.team;

            if(player.team == "allies")
              player setplayermusicstate(level.cursuspsensetrack["allies"]);
            else
              player setplayermusicstate(level.cursuspsensetrack["axis"]);
          }
        }
      }
    }
  }
}

suspensemusic_reset(waittime) {
  wait(waittime);
  self.nosuspensemusic = undefined;
}

stopsuspensemusic() {
  level notify("stop_suspense_music");

  if(isDefined(level.cursuspsensetrack) && level.cursuspsensetrack.size == 2)
    _func_6F9B54CEA87F1C9E();
}

_id_231DD20BC5A6BD68() {
  level endon("game_ended");

  for(;;) {
    wait(randomfloatrange(90, 150));

    if(!_id_2C3C990BA58FA6F5::_id_D3915632A8C61EB2()) {
      return;
    }
    foreach(player in level.players) {
      if(!isDefined(player.nosuspensemusic))
        player setplayermusicstate("mx_mp_dmz_darkmoods_playlist");
    }
  }
}

enablemusic() {
  if(level.musicenabled == 0)
    thread suspensemusic();

  level.musicenabled++;
}

disablemusic() {
  if(!isDefined(level.musicenabled))
    level.musicenabled = 0;
  else if(level.musicenabled > 0) {
    level.musicenabled--;

    if(level.musicenabled == 0)
      stopsuspensemusic();
  }
}

round_end_music(winner, _id_F0500919D8C387B9, _id_656B99FC50E799AE) {
  if(isDefined(level.endmusicplayed)) {
    return;
  }
  if(scripts\mp\utility\game::getgametype() == "ballmode") {
    return;
  }
  if(level.halftimetype == "halftime" && level.roundlimit && game["roundsPlayed"] * 2 == level.roundlimit)
    setmusicstate("mus_mp_halftime");
  else if(level.playovertime)
    setmusicstate("mus_mp_halftime");
  else if(level.halftimetype == "halftime" && !level.roundlimit) {
    foreach(player in level.players) {
      if(winner == "allies") {
        if(scripts\mp\utility\game::getgametype() != "arena") {
          if(isDefined(player.team) && player.team == "allies") {
            if(isDefined(player._id_ACFBB9CAED7125F9) && player._id_ACFBB9CAED7125F9 == 1) {
              _id_5C4AF3CBE0A030EE = _id_7AB5B649FA408138::_id_17EE301CF0B5BA85("roundwin_allies_classic");
              player setplayermusicstate(_id_5C4AF3CBE0A030EE);
            } else {
              _id_5C4AF3CBE0A030EE = _id_7AB5B649FA408138::_id_17EE301CF0B5BA85("roundwin_allies");
              player setplayermusicstate(_id_5C4AF3CBE0A030EE);
            }
          } else if(isDefined(player._id_ACFBB9CAED7125F9) && player._id_ACFBB9CAED7125F9 == 1) {
            _id_B9F676BCFD9C687C = _id_7AB5B649FA408138::_id_17EE301CF0B5BA85("roundloss_axis_classic");
            player setplayermusicstate(_id_B9F676BCFD9C687C);
          } else {
            _id_B9F676BCFD9C687C = _id_7AB5B649FA408138::_id_17EE301CF0B5BA85("roundloss_axis");
            player setplayermusicstate(_id_B9F676BCFD9C687C);
          }
        } else if(isDefined(player.team) && player.team == "allies") {
          if(isDefined(player._id_ACFBB9CAED7125F9) && player._id_ACFBB9CAED7125F9 == 1) {
            _id_6859545DDD7E8B2F = getarenaroundendmusictype();
            _id_B2DB50F40A42BDF0 = _id_7AB5B649FA408138::_id_17EE301CF0B5BA85("gunfight_roundwin_" + _id_6859545DDD7E8B2F + "_classic");
            player setplayermusicstate(_id_B2DB50F40A42BDF0);
          } else {
            _id_6859545DDD7E8B2F = getarenaroundendmusictype();
            _id_B2DB50F40A42BDF0 = _id_7AB5B649FA408138::_id_17EE301CF0B5BA85("gunfight_roundwin_" + _id_6859545DDD7E8B2F);
            player setplayermusicstate(_id_B2DB50F40A42BDF0);
          }
        } else if(isDefined(player._id_ACFBB9CAED7125F9) && player._id_ACFBB9CAED7125F9 == 1) {
          _id_6859545DDD7E8B2F = getarenaroundendmusictype();
          _id_A5C0FD0DFD79A819 = _id_7AB5B649FA408138::_id_17EE301CF0B5BA85("gunfight_roundloss_" + _id_6859545DDD7E8B2F + "_classic");
          player setplayermusicstate(_id_A5C0FD0DFD79A819);
        } else {
          _id_6859545DDD7E8B2F = getarenaroundendmusictype();
          _id_A5C0FD0DFD79A819 = _id_7AB5B649FA408138::_id_17EE301CF0B5BA85("gunfight_roundloss_" + _id_6859545DDD7E8B2F);
          player setplayermusicstate(_id_A5C0FD0DFD79A819);
        }

        continue;
      }

      if(winner == "axis") {
        if(scripts\mp\utility\game::getgametype() != "arena") {
          if(isDefined(player.team) && player.team == "allies") {
            if(isDefined(player._id_ACFBB9CAED7125F9) && player._id_ACFBB9CAED7125F9 == 1) {
              _id_48CAADA842FC5DF7 = _id_7AB5B649FA408138::_id_17EE301CF0B5BA85("roundloss_allies_classic");
              player setplayermusicstate(_id_48CAADA842FC5DF7);
            } else {
              _id_48CAADA842FC5DF7 = _id_7AB5B649FA408138::_id_17EE301CF0B5BA85("roundloss_allies");
              player setplayermusicstate(_id_48CAADA842FC5DF7);
            }
          } else if(isDefined(player._id_ACFBB9CAED7125F9) && player._id_ACFBB9CAED7125F9 == 1) {
            _id_7A74F0F97389ED99 = _id_7AB5B649FA408138::_id_17EE301CF0B5BA85("roundwin_axis_classic");
            player setplayermusicstate(_id_7A74F0F97389ED99);
          } else {
            _id_7A74F0F97389ED99 = _id_7AB5B649FA408138::_id_17EE301CF0B5BA85("roundwin_axis");
            player setplayermusicstate(_id_7A74F0F97389ED99);
          }
        } else if(isDefined(player.team) && player.team == "allies") {
          if(isDefined(player._id_ACFBB9CAED7125F9) && player._id_ACFBB9CAED7125F9 == 1) {
            _id_6859545DDD7E8B2F = getarenaroundendmusictype();
            _id_A5C0FD0DFD79A819 = _id_7AB5B649FA408138::_id_17EE301CF0B5BA85("gunfight_roundloss_" + _id_6859545DDD7E8B2F + "_classic");
            player setplayermusicstate(_id_A5C0FD0DFD79A819);
          } else {
            _id_6859545DDD7E8B2F = getarenaroundendmusictype();
            _id_A5C0FD0DFD79A819 = _id_7AB5B649FA408138::_id_17EE301CF0B5BA85("gunfight_roundloss_" + _id_6859545DDD7E8B2F);
            player setplayermusicstate(_id_A5C0FD0DFD79A819);
          }
        } else if(isDefined(player._id_ACFBB9CAED7125F9) && player._id_ACFBB9CAED7125F9 == 1) {
          _id_6859545DDD7E8B2F = getarenaroundendmusictype();
          _id_B2DB50F40A42BDF0 = _id_7AB5B649FA408138::_id_17EE301CF0B5BA85("gunfight_roundwin_" + _id_6859545DDD7E8B2F + "_classic");
          player setplayermusicstate(_id_B2DB50F40A42BDF0);
        } else {
          _id_6859545DDD7E8B2F = getarenaroundendmusictype();
          _id_B2DB50F40A42BDF0 = _id_7AB5B649FA408138::_id_17EE301CF0B5BA85("gunfight_roundwin_" + _id_6859545DDD7E8B2F);
          player setplayermusicstate(_id_B2DB50F40A42BDF0);
        }

        continue;
      }

      if(scripts\mp\utility\game::getgametype() != "arena") {
        if(isDefined(player._id_ACFBB9CAED7125F9) && player._id_ACFBB9CAED7125F9 == 1) {
          _id_6BB0B34D3F44787D = _id_7AB5B649FA408138::_id_17EE301CF0B5BA85("rounddraw_classic");
          player setplayermusicstate(_id_6BB0B34D3F44787D);
        } else
          player setplayermusicstate("mp_round_draw_playlist");

        continue;
      }

      if(isDefined(player._id_ACFBB9CAED7125F9) && player._id_ACFBB9CAED7125F9 == 1) {
        _id_6859545DDD7E8B2F = getarenaroundendmusictype();
        _id_B2DB50F40A42BDF0 = _id_7AB5B649FA408138::_id_17EE301CF0B5BA85("gunfight_roundwin_" + _id_6859545DDD7E8B2F + "_classic");
        player setplayermusicstate(_id_B2DB50F40A42BDF0);
      } else {
        _id_6859545DDD7E8B2F = getarenaroundendmusictype();
        _id_B2DB50F40A42BDF0 = _id_7AB5B649FA408138::_id_17EE301CF0B5BA85("gunfight_roundwin_" + _id_6859545DDD7E8B2F);
        player setplayermusicstate(_id_B2DB50F40A42BDF0);
      }
    }
  } else if(level.halftimetype == "halftime" && scripts\mp\utility\game::getgametype() == "dd" && !scripts\mp\utility\game::hitroundlimit()) {
    foreach(player in level.players) {
      if(winner == "allies") {
        if(isDefined(player.team) && player.team == "allies") {
          if(isDefined(player._id_ACFBB9CAED7125F9) && player._id_ACFBB9CAED7125F9 == 1) {
            _id_5C4AF3CBE0A030EE = _id_7AB5B649FA408138::_id_17EE301CF0B5BA85("roundwin_allies_classic");
            player setplayermusicstate(_id_5C4AF3CBE0A030EE);
          } else {
            _id_5C4AF3CBE0A030EE = _id_7AB5B649FA408138::_id_17EE301CF0B5BA85("roundwin_allies");
            player setplayermusicstate(_id_5C4AF3CBE0A030EE);
          }
        } else if(isDefined(player._id_ACFBB9CAED7125F9) && player._id_ACFBB9CAED7125F9 == 1) {
          _id_B9F676BCFD9C687C = _id_7AB5B649FA408138::_id_17EE301CF0B5BA85("roundloss_axis_classic");
          player setplayermusicstate(_id_B9F676BCFD9C687C);
        } else {
          _id_B9F676BCFD9C687C = _id_7AB5B649FA408138::_id_17EE301CF0B5BA85("roundloss_axis");
          player setplayermusicstate(_id_B9F676BCFD9C687C);
        }

        continue;
      }

      if(winner == "axis") {
        if(isDefined(player.team) && player.team == "allies") {
          if(isDefined(player._id_ACFBB9CAED7125F9) && player._id_ACFBB9CAED7125F9 == 1) {
            _id_48CAADA842FC5DF7 = _id_7AB5B649FA408138::_id_17EE301CF0B5BA85("roundloss_allies_classic");
            player setplayermusicstate(_id_48CAADA842FC5DF7);
          } else {
            _id_48CAADA842FC5DF7 = _id_7AB5B649FA408138::_id_17EE301CF0B5BA85("roundloss_allies");
            player setplayermusicstate(_id_48CAADA842FC5DF7);
          }
        } else if(isDefined(player._id_ACFBB9CAED7125F9) && player._id_ACFBB9CAED7125F9 == 1) {
          _id_7A74F0F97389ED99 = _id_7AB5B649FA408138::_id_17EE301CF0B5BA85("roundwin_axis_classic");
          player setplayermusicstate(_id_7A74F0F97389ED99);
        } else {
          _id_7A74F0F97389ED99 = _id_7AB5B649FA408138::_id_17EE301CF0B5BA85("roundwin_axis");
          player setplayermusicstate(_id_7A74F0F97389ED99);
        }

        continue;
      }

      if(isDefined(player._id_ACFBB9CAED7125F9) && player._id_ACFBB9CAED7125F9 == 1) {
        _id_6BB0B34D3F44787D = _id_7AB5B649FA408138::_id_17EE301CF0B5BA85("rounddraw_classic");
        player setplayermusicstate(_id_6BB0B34D3F44787D);
        continue;
      }

      player setplayermusicstate("mp_round_draw_playlist");
    }
  }
}

getarenaroundendmusictype() {
  _id_DC1F442C2A011890 = "early";
  _id_2A558C1BC57F2D69 = 0;

  foreach(_id_F90358454413407F in level.teamnamelist) {
    _id_C077C467A67F3354 = game["roundsWon"][_id_F90358454413407F];

    if(_id_C077C467A67F3354 > _id_2A558C1BC57F2D69)
      _id_2A558C1BC57F2D69 = _id_C077C467A67F3354;
  }

  if(_id_2A558C1BC57F2D69 > 0) {
    _id_072BC79F0750FCA9 = _id_2A558C1BC57F2D69 / level.winlimit;

    if(_id_072BC79F0750FCA9 <= 0.34)
      _id_DC1F442C2A011890 = "early";
    else if(_id_072BC79F0750FCA9 >= 0.34 && _id_072BC79F0750FCA9 <= 0.67)
      _id_DC1F442C2A011890 = "mid";
    else
      _id_DC1F442C2A011890 = "late";
  }

  return _id_DC1F442C2A011890;
}

_id_AECAFE54C65C0E35(players) {
  players = scripts\engine\utility::_id_53C4C53197386572(players, level.players);
  _id_5E2FBD511E678760 = [];

  if(isarray(players)) {
    foreach(player in players) {
      _id_DE14D878883D4C57 = player _id_2CEDCC356F1B9FC8::isplayerinorgoingtogulag();

      if(isPlayer(player) && !isagent(player) && !isbot(player) && !_id_DE14D878883D4C57)
        _id_5E2FBD511E678760[_id_5E2FBD511E678760.size] = player;
    }
  }

  return _id_5E2FBD511E678760;
}

_id_A486DF26072A530A(circleindex, _id_35157F8DF527FFAD, _id_2948CA54731DE34F) {
  level endon("game_ended");

  if(!isDefined(level.playedinfilmusic) && level.brgametype.name != "truckwar") {
    return;
  }
  _id_2948CA54731DE34F = scripts\engine\utility::_id_53C4C53197386572(_id_2948CA54731DE34F, 0.05);

  if(isstruct(level.br_circle)) {
    if(isnumber(level.br_circle._id_DA6C0F6A12518740) && level.br_circle._id_DA6C0F6A12518740 == circleindex)
      return;
    else
      level.br_circle._id_DA6C0F6A12518740 = circleindex;
  }

  _id_272B0EE396E8A69A = int(_id_35157F8DF527FFAD - 1.0);
  _id_1B32FDED15194CC7 = _id_272B0EE396E8A69A / 3.0;
  _id_03494D23F34A9DAC = int(floor(_id_1B32FDED15194CC7));
  _id_61D4CF0C14F1B38F = int(_id_03494D23F34A9DAC * 3.0);
  _id_695ACFE00695DA06 = int(max(0.0, _id_272B0EE396E8A69A - _id_61D4CF0C14F1B38F));
  _id_1DE6C353A6694763 = int(_id_03494D23F34A9DAC) - 1;
  _id_138F041FF5D8FECB = int(_id_03494D23F34A9DAC * 2 + _id_695ACFE00695DA06) - 1;
  _id_D9EC05FDC8A389A7 = int(_id_03494D23F34A9DAC * 3);
  _id_470558031A366939 = int(max(1.0, _id_35157F8DF527FFAD - 1.0));
  waittime = max(0.05, _id_2948CA54731DE34F);
  wait(waittime);
  _id_D7A79F6B50712F98 = "";
  _id_96DD8AB6925778D3 = "";

  if(circleindex <= _id_1DE6C353A6694763) {
    _id_D7A79F6B50712F98 = _id_7AB5B649FA408138::_id_17EE301CF0B5BA85("br_ring_low");
    _id_96DD8AB6925778D3 = _id_7AB5B649FA408138::_id_17EE301CF0B5BA85("br_ring_low_classic");
  } else if(circleindex <= _id_138F041FF5D8FECB) {
    _id_D7A79F6B50712F98 = _id_7AB5B649FA408138::_id_17EE301CF0B5BA85("br_ring_med");
    _id_96DD8AB6925778D3 = _id_7AB5B649FA408138::_id_17EE301CF0B5BA85("br_ring_med_classic");
  } else if(circleindex <= _id_D9EC05FDC8A389A7) {
    _id_D7A79F6B50712F98 = _id_7AB5B649FA408138::_id_17EE301CF0B5BA85("br_ring_high");
    _id_96DD8AB6925778D3 = _id_7AB5B649FA408138::_id_17EE301CF0B5BA85("br_ring_high_classic");
  } else if(circleindex == _id_470558031A366939) {
    _id_D7A79F6B50712F98 = _id_7AB5B649FA408138::_id_17EE301CF0B5BA85("br_ring_final");
    _id_96DD8AB6925778D3 = _id_7AB5B649FA408138::_id_17EE301CF0B5BA85("br_ring_final_classic");
  }

  players = _id_AECAFE54C65C0E35();
  _id_7AB5B649FA408138::_id_FE75A89529DD0FD0(players, _id_D7A79F6B50712F98, undefined, undefined, _id_96DD8AB6925778D3);

  if(circleindex != _id_470558031A366939) {
    wait 30;
    _id_7AB5B649FA408138::_id_FE75A89529DD0FD0(players, "", undefined, "wartracks");
  }
}

plunder_tenpercent_music() {
  level notify("stop_suspense_music");
}

plunder_thirtypercent_music() {
  level endon("fiftypercent_music");

  if(isDefined(level.thirtypercent_music) && level.thirtypercent_music == 1) {
    return;
  }
  if(_id_2CEDCC356F1B9FC8::_id_D6AE35E0CE14BBAF()) {
    return;
  }
  level notify("stop_suspense_music");

  foreach(player in level.players) {
    if(isDefined(player._id_ACFBB9CAED7125F9) && player._id_ACFBB9CAED7125F9 == 1) {
      _id_17C8D9E220164807 = game["music"]["plunder_tenpercent_classic"].size;
      _id_DCC499C9734611F8 = randomint(_id_17C8D9E220164807);
      player setplayermusicstate(game["music"]["plunder_tenpercent_classic"][_id_DCC499C9734611F8]);
      continue;
    }

    _id_17C8D9E220164807 = game["music"]["plunder_tenpercent"].size;
    _id_DCC499C9734611F8 = randomint(_id_17C8D9E220164807);
    player setplayermusicstate(game["music"]["plunder_tenpercent"][_id_DCC499C9734611F8]);
  }

  level.thirtypercent_music = 1;
}

plunder_fiftypercent_music(team) {
  level endon("seventyfivepercent_music");

  if(isDefined(level.fiftypercent_music) && level.fiftypercent_music == 1) {
    return;
  }
  if(_id_2CEDCC356F1B9FC8::_id_D6AE35E0CE14BBAF()) {
    return;
  }
  foreach(player in level.players) {
    if(isDefined(player._id_ACFBB9CAED7125F9) && player._id_ACFBB9CAED7125F9 == 1) {
      _id_17C8D9E220164807 = game["music"]["plunder_thirtypercent_classic"].size;
      _id_DCC499C9734611F8 = randomint(_id_17C8D9E220164807);
      player setplayermusicstate(game["music"]["plunder_thirtypercent_classic"][_id_DCC499C9734611F8]);
      continue;
    }

    _id_17C8D9E220164807 = game["music"]["plunder_thirtypercent"].size;
    _id_DCC499C9734611F8 = randomint(_id_17C8D9E220164807);
    player setplayermusicstate(game["music"]["plunder_thirtypercent"][_id_DCC499C9734611F8]);
  }

  level.fiftypercent_music = 1;
  level notify("fiftypercent_music");
}

plunder_seventyfivepercent_music(team) {
  level endon("ninetypercent_music");

  if(isDefined(level.seventyfivepercent_music) && level.seventyfivepercent_music == 1) {
    return;
  }
  if(_id_2CEDCC356F1B9FC8::_id_D6AE35E0CE14BBAF()) {
    return;
  }
  foreach(player in level.players) {
    if(isDefined(player._id_ACFBB9CAED7125F9) && player._id_ACFBB9CAED7125F9 == 1) {
      _id_17C8D9E220164807 = game["music"]["plunder_fiftypercent_classic"].size;
      _id_DCC499C9734611F8 = randomint(_id_17C8D9E220164807);
      player setplayermusicstate(game["music"]["plunder_fiftypercent_classic"][_id_DCC499C9734611F8]);
      continue;
    }

    _id_17C8D9E220164807 = game["music"]["plunder_fiftypercent"].size;
    _id_DCC499C9734611F8 = randomint(_id_17C8D9E220164807);
    player setplayermusicstate(game["music"]["plunder_fiftypercent"][_id_DCC499C9734611F8]);
  }

  level.seventyfivepercent_music = 1;
  level notify("seventyfivepercent_music");
}

plunder_ninetypercent_music(team) {
  if(isDefined(level.ninetypercent_music) && level.ninetypercent_music == 1) {
    return;
  }
  if(_id_2CEDCC356F1B9FC8::_id_D6AE35E0CE14BBAF()) {
    return;
  }
  foreach(player in level.players) {
    if(isDefined(player._id_ACFBB9CAED7125F9) && player._id_ACFBB9CAED7125F9 == 1) {
      _id_17C8D9E220164807 = game["music"]["plunder_seventyfivepercent_classic"].size;
      _id_DCC499C9734611F8 = randomint(_id_17C8D9E220164807);
      player setplayermusicstate(game["music"]["plunder_seventyfivepercent_classic"][_id_DCC499C9734611F8]);
      continue;
    }

    _id_17C8D9E220164807 = game["music"]["plunder_seventyfivepercent"].size;
    _id_DCC499C9734611F8 = randomint(_id_17C8D9E220164807);
    player setplayermusicstate(game["music"]["plunder_seventyfivepercent"][_id_DCC499C9734611F8]);
  }

  level.ninetypercent_music = 1;
  level notify("ninetypercent_music");
}

plunder_overtime_music() {
  if(isDefined(level.overtime_music) && level.overtime_music == 1) {
    return;
  }
  if(_id_2CEDCC356F1B9FC8::_id_D6AE35E0CE14BBAF()) {
    return;
  }
  foreach(player in level.players) {
    if(isDefined(player._id_ACFBB9CAED7125F9) && player._id_ACFBB9CAED7125F9 == 1) {
      _id_17C8D9E220164807 = game["music"]["plunder_ninetypercent_classic"].size;
      _id_DCC499C9734611F8 = randomint(_id_17C8D9E220164807);
      player setplayermusicstate(game["music"]["plunder_ninetypercent_classic"][_id_DCC499C9734611F8]);
      continue;
    }

    _id_17C8D9E220164807 = game["music"]["plunder_ninetypercent"].size;
    _id_DCC499C9734611F8 = randomint(_id_17C8D9E220164807);
    player setplayermusicstate(game["music"]["plunder_ninetypercent"][_id_DCC499C9734611F8]);
  }

  level.overtime_music = 1;
}

_id_283A36147406B42F() {
  if(istrue(level.overtime_music)) {
    return;
  }
  foreach(player in level.players) {
    if(isDefined(player._id_ACFBB9CAED7125F9) && player._id_ACFBB9CAED7125F9 == 1) {
      _id_17C8D9E220164807 = game["music"]["plunder_bonustime_long_classic"].size;
      _id_DCC499C9734611F8 = randomint(_id_17C8D9E220164807);
      player setplayermusicstate(game["music"]["plunder_bonustime_long_classic"][_id_DCC499C9734611F8]);
      continue;
    }

    _id_17C8D9E220164807 = game["music"]["plunder_bonustime_long"].size;
    _id_DCC499C9734611F8 = randomint(_id_17C8D9E220164807);
    player setplayermusicstate(game["music"]["plunder_bonustime_long"][_id_DCC499C9734611F8]);
  }

  level.overtime_music = 1;
}

_id_C080EBBCDCC3176F() {
  if(!isDefined(self._id_43653D344AA392AF)) {
    self._id_43653D344AA392AF = 1;
    self setplayermusicstate("iw9_mp_dmz_biobunker_enter");
  }
}

ismusicenabled() {
  return level.musicenabled > 0;
}

_id_535120141F535B49() {
  self endon("disconnect");
  level endon("game_ended");
  stopsuspensemusic();

  if(!isDefined(self._id_8EC3C32833063AAA))
    self._id_8EC3C32833063AAA = 0;

  if(!isDefined(self._id_33ED4A0A9CCD0F0A))
    self._id_33ED4A0A9CCD0F0A = 0;

  if(!isDefined(self._id_E37DAD9B93DAE844))
    self._id_E37DAD9B93DAE844 = 0;

  for(;;) {
    _id_65C6ED2A9E69239A = self._id_8EC3C32833063AAA - self._id_33ED4A0A9CCD0F0A;

    if(self._id_8EC3C32833063AAA >= 0)
      self._id_33ED4A0A9CCD0F0A = self._id_8EC3C32833063AAA;

    iprintln("current music diff is " + _id_65C6ED2A9E69239A);

    if(_id_65C6ED2A9E69239A > 0) {
      if(_id_65C6ED2A9E69239A > 1 && _id_65C6ED2A9E69239A < 6) {
        if(!isDefined(self._id_CF8537C71BFA2021))
          thread _id_32E2796E3DBF61AC();
      } else if(_id_65C6ED2A9E69239A >= 6 && _id_65C6ED2A9E69239A <= 15) {
        if(!isDefined(self._id_C369F1C713FAFF19))
          thread _id_3F789F6E464550D8();
      } else if(_id_65C6ED2A9E69239A > 15) {
        if(!isDefined(self._id_992116460039917D))
          thread _id_EE789BCA4D90F206();
      }
    }

    if(_id_65C6ED2A9E69239A < 0) {
      if(_id_65C6ED2A9E69239A <= -5 && _id_65C6ED2A9E69239A > -10) {
        if(isDefined(self._id_C369F1C713FAFF19) || isDefined(self._id_992116460039917D) || isDefined(self._id_CF8537C71BFA2021)) {
          self setsoundsubmix("iw9_mp_musictest_fadeout", 4);
          self notify("clear_music_low");
          self notify("clear_music_med");
          self notify("clear_music_high");
          self._id_CF8537C71BFA2021 = undefined;
          self._id_992116460039917D = undefined;
          self._id_C369F1C713FAFF19 = undefined;
          wait(self._id_E37DAD9B93DAE844 + 10);

          if(self._id_8EC3C32833063AAA >= 0)
            self._id_33ED4A0A9CCD0F0A = self._id_8EC3C32833063AAA;

          self stoplocalsound("mus_iw9_mpmusictest_ambient1_intro");
          self clearsoundsubmix("iw9_mp_musictest_fadeout", 2);
        }
      } else if(_id_65C6ED2A9E69239A < -10) {
        if(isDefined(self._id_C369F1C713FAFF19) || isDefined(self._id_992116460039917D))
          self playlocalsound("mus_iw9_mpmusictest_hit1_intro");

        if(isDefined(self._id_C369F1C713FAFF19) || isDefined(self._id_992116460039917D) || isDefined(self._id_CF8537C71BFA2021)) {
          self setsoundsubmix("iw9_mp_musictest_fadeout", 2);
          self notify("clear_music_low");
          self notify("clear_music_med");
          self notify("clear_music_high");
          self._id_CF8537C71BFA2021 = undefined;
          self._id_992116460039917D = undefined;
          self._id_C369F1C713FAFF19 = undefined;
          wait(self._id_E37DAD9B93DAE844 + 10);

          if(self._id_8EC3C32833063AAA >= 0)
            self._id_33ED4A0A9CCD0F0A = self._id_8EC3C32833063AAA;

          self stoplocalsound("mus_iw9_mpmusictest_ambient1_intro");
          self clearsoundsubmix("iw9_mp_musictest_fadeout", 2);
        }
      }
    }

    if(self._id_8EC3C32833063AAA >= 0)
      self._id_8EC3C32833063AAA = self._id_8EC3C32833063AAA - 0.5;

    if(self._id_8EC3C32833063AAA < 0)
      self._id_8EC3C32833063AAA = 0;

    iprintln("current music value is " + self._id_8EC3C32833063AAA);
    wait 2;

    if(self._id_E37DAD9B93DAE844 > 0) {
      self._id_E37DAD9B93DAE844 = self._id_E37DAD9B93DAE844 - 2;

      if(self._id_E37DAD9B93DAE844 < 0)
        self._id_E37DAD9B93DAE844 = 0;
    }
  }
}

_id_32E2796E3DBF61AC() {
  self endon("disconnect");
  self endon("clear_music_low");
  level endon("game_ended");

  if(!isDefined(self._id_CF8537C71BFA2021)) {
    self._id_CF8537C71BFA2021 = 1;
    self playlocalsound("mus_iw9_mpmusictest_ambient1_intro");
    iprintln("adding low music");
    self._id_E37DAD9B93DAE844 = 25;
    wait(self._id_E37DAD9B93DAE844);
    iprintln("low music state cleared");
    self._id_CF8537C71BFA2021 = undefined;
  }
}

_id_3F789F6E464550D8() {
  self endon("disconnect");
  self endon("clear_music_med");
  level endon("game_ended");

  if(isDefined(self._id_992116460039917D)) {
    self._id_992116460039917D = 1;
    self._id_C369F1C713FAFF19 = 1;
    self clearsoundsubmix("iw9_mp_musictest_fadeout", 2);
    self setplayermusicstate("");
    self notify("clear_music_high");
    iprintln("adding med music");
    self._id_E37DAD9B93DAE844 = 21;
    wait(self._id_E37DAD9B93DAE844);
    iprintln("music states cleared");
    self._id_992116460039917D = undefined;
    self._id_C369F1C713FAFF19 = undefined;
  } else {
    self._id_C369F1C713FAFF19 = 1;
    self clearsoundsubmix("iw9_mp_musictest_fadeout", 2);
    self setplayermusicstate("iw9_mpmusictest_perc1");
    iprintln("adding med music");
    self._id_E37DAD9B93DAE844 = 21;
    wait(self._id_E37DAD9B93DAE844 - 2);
    self setsoundsubmix("iw9_mp_musictest_fadeout", 2);
    self stopplayermusicstate("iw9_mpmusictest_perc1");
    wait(self._id_E37DAD9B93DAE844 + 2);
    iprintln("med music state cleared");
    self._id_C369F1C713FAFF19 = undefined;
  }
}

_id_EE789BCA4D90F206() {
  self endon("disconnect");
  self endon("clear_music_high");
  level endon("game_ended");

  if(isDefined(self._id_C369F1C713FAFF19)) {
    self._id_992116460039917D = 1;
    self._id_C369F1C713FAFF19 = 1;
    self setplayermusicstate("");
    self clearsoundsubmix("iw9_mp_musictest_fadeout", 2);
    self notify("clear_music_med");
    iprintln("adding high music");
    self._id_E37DAD9B93DAE844 = 31;
    wait(self._id_E37DAD9B93DAE844);
    iprintln("music states cleared");
    self._id_992116460039917D = undefined;
    self._id_C369F1C713FAFF19 = undefined;
  } else {
    self._id_992116460039917D = 1;
    self clearsoundsubmix("iw9_mp_musictest_fadeout", 2);
    self setplayermusicstate("iw9_mpmusictest_bass1");
    iprintln("adding high music");
    self._id_E37DAD9B93DAE844 = 30.5;
    wait(self._id_E37DAD9B93DAE844 - 2);
    self setsoundsubmix("iw9_mp_musictest_fadeout", 2);
    self stopplayermusicstate("iw9_mpmusictest_bass1");
    wait(self._id_E37DAD9B93DAE844 + 2);
    iprintln("high music state cleared");
    self._id_992116460039917D = undefined;
  }
}