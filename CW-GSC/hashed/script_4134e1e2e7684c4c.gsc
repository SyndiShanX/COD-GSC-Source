/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: hashed\script_4134e1e2e7684c4c.gsc
***********************************************/

#using script_35ae72be7b4fec10;
#using script_3dc93ca9902a9cda;
#using scripts\cp_common\gametypes\globallogic_ui;

#namespace namespace_6f1d35e1;

function function_eea42dd9(var_f873ed0b, var_e3ec46f0) {
  level.var_deff0f73 = [];

  if(scripted_widgets::exists(#"hash_15363747d8cbf71f")) {
    scripted_widgets::remove(#"hash_15363747d8cbf71f");
    waitframe(1);
  }

  scripted_widgets::create(#"hash_15363747d8cbf71f", var_f873ed0b);
  scripted_widgets::function_b1e6d7a8(#"hash_15363747d8cbf71f", 0, 1);
  scripted_widgets::function_d3c3e5c3(#"hash_15363747d8cbf71f", [#"dialog_tree", #"interactive_map"]);

  if(is_true(var_e3ec46f0)) {
    scripted_widgets::function_28027c42(#"computer", #"hash_15363747d8cbf71f");
  }
}

function function_487b4340(var_e1ab1198, var_5130c92a = 1, var_907c1dab) {
  var_deff0f73 = getscriptbundle(var_e1ab1198);
  assert(isDefined(var_deff0f73), "<dev string:x38>" + var_e1ab1198);

  if(!isDefined(var_907c1dab)) {
    var_907c1dab = 0;
  }

  if(var_5130c92a) {
    function_f99d2e8a();
    level.var_deff0f73 = var_deff0f73.var_df2d0a90;
    len = level.var_deff0f73.size;

    for(i = 0; i < len; i++) {
      linenum = i + 1;
      var_c1deb575 = level.var_deff0f73[i];
      function_66b8c40f(var_c1deb575, linenum);
    }

    scripted_widgets::set_count(#"hash_15363747d8cbf71f", -1, 1);
    scripted_widgets::set_state(#"hash_15363747d8cbf71f", var_907c1dab);
    return;
  }

  level.var_deff0f73 = var_deff0f73.var_df2d0a90;
  scripted_widgets::function_330981ed(#"hash_15363747d8cbf71f");
}

function function_93dd719c(var_9d391884, var_80d5359e = 0) {
  assert(ishash(var_9d391884), "<dev string:x76>");
  scripted_widgets::function_bfdab223(#"hash_15363747d8cbf71f", var_9d391884, var_80d5359e);
}

function function_14291ddf(var_c51f6b35) {
  assert(ishash(var_c51f6b35), "<dev string:xa6>");
  scripted_widgets::function_309bf7c2(#"hash_15363747d8cbf71f", var_c51f6b35);
}

function function_ca5c7f26(var_b8f68f4, value) {
  scripted_widgets::function_9ade1d9b(#"hash_15363747d8cbf71f", var_b8f68f4, value);
}

function function_314087bb(line) {
  assert(isDefined(level.var_deff0f73) && line > 0 && line <= level.var_deff0f73.size);
  var_307d638e = level.var_deff0f73[line - 1];
  function_66b8c40f(var_307d638e, line);
}

function function_d599de13(var_e0e4e6f6) {
  if(scripted_widgets::exists(#"hash_15363747d8cbf71f")) {
    scripted_widgets::set_state(#"hash_15363747d8cbf71f", var_e0e4e6f6);
  }
}

function function_5d2e6f6a(var_eac515a1) {
  if(scripted_widgets::exists(#"hash_15363747d8cbf71f")) {
    scripted_widgets::set_count(#"hash_15363747d8cbf71f", var_eac515a1, 1);
  }
}

function function_4951a2c8(line, var_1eb4675d = 120, var_80d5359e = 0) {
  if(scripted_widgets::exists(#"hash_15363747d8cbf71f")) {
    dataindex = line - 1;
    var_c1deb575 = level.var_deff0f73[dataindex];
    scripted_widgets::function_f2a9266(#"hash_15363747d8cbf71f", line, "ActiveIndex", line);
    scripted_widgets::function_f2a9266(#"hash_15363747d8cbf71f", line, "TypeSpeed", var_1eb4675d, undefined, var_80d5359e);
  }
}

function function_6f3be7df(value) {
  if(scripted_widgets::exists(#"hash_15363747d8cbf71f")) {
    scripted_widgets::function_b1e6d7a8(#"hash_15363747d8cbf71f", value, 1);
  }
}

function function_61f5c9b7(line) {
  scripted_widgets::function_f2a9266(#"hash_15363747d8cbf71f", line, "ContentLine", #"");
  scripted_widgets::function_f2a9266(#"hash_15363747d8cbf71f", line, "CustomText", #"");
}

function function_5109bc1e(line, colorindex) {
  scripted_widgets::function_f2a9266(#"hash_15363747d8cbf71f", line, "ColorIndex", colorindex);
}

function function_5cffb9f2(var_a9e138ad, line, var_a19ff8a1 = 0, var_5964aaa = 0, var_1eb4675d = 120) {
  scripted_widgets::function_f2a9266(#"hash_15363747d8cbf71f", line, "ActiveIndex", line);
  scripted_widgets::function_f2a9266(#"hash_15363747d8cbf71f", line, "MaskText", var_a19ff8a1);
  scripted_widgets::function_f2a9266(#"hash_15363747d8cbf71f", line, "TypeSpeed", var_1eb4675d);
  scripted_widgets::function_f2a9266(#"hash_15363747d8cbf71f", line, "TypingSFXAlias", "uin_cp_typing_keyboard");
  scripted_widgets::function_f2a9266(#"hash_15363747d8cbf71f", line, "CustomText", var_a9e138ad);
  scripted_widgets::function_f2a9266(#"hash_15363747d8cbf71f", line, "RemoveCursorOnComplete", var_5964aaa);
}

function function_6f9dba44(line, content) {
  scripted_widgets::function_f2a9266(#"hash_15363747d8cbf71f", line, "ContentLine", content);
}

function ShowNewLineMarker(line, show) {
  scripted_widgets::function_f2a9266(#"hash_15363747d8cbf71f", line, "ShowNewLineMarker", show);
}

function function_635c370c(line, HideCursor) {
  scripted_widgets::function_f2a9266(#"hash_15363747d8cbf71f", line, "HideCursor", HideCursor);
}

function function_8a58b10c(line, type) {
  scripted_widgets::function_f2a9266(#"hash_15363747d8cbf71f", line, "EditBox.Type", type);
}

function function_29438cc(line, max_chars) {
  scripted_widgets::function_f2a9266(#"hash_15363747d8cbf71f", line, "EditBox.MaxChars", max_chars);
}

function function_28321961(line, var_95779987) {
  scripted_widgets::function_f2a9266(#"hash_15363747d8cbf71f", line, "EditBox.NumericalInteger", var_95779987);
}

function function_7bfd800c(line, var_55cd035) {
  scripted_widgets::function_f2a9266(#"hash_15363747d8cbf71f", line, "EditBox.NumericalMin", var_55cd035);
}

function function_be760dc8(line, var_c4919c78) {
  scripted_widgets::function_f2a9266(#"hash_15363747d8cbf71f", line, "EditBox.NumericalMax", var_c4919c78);
}

function function_6ed8776d(line, focus, force) {
  scripted_widgets::function_f2a9266(#"hash_15363747d8cbf71f", line, "EditBox.Focus", focus, undefined, force);
}

function function_f887fdff(line) {
  return scripted_widgets::function_ce8141d4(#"hash_15363747d8cbf71f", line, "EditBox.Entry");
}

function function_9806766(line, entry) {
  scripted_widgets::function_f2a9266(#"hash_15363747d8cbf71f", line, "EditBox.Entry", entry);
}

function function_f6fbe41(line, entry) {
  scripted_widgets::function_f2a9266(#"hash_15363747d8cbf71f", line, "EditBox.LocalizedEntry", entry);
}

function function_b2911127(delay = 2) {
  if(scripted_widgets::exists(#"hash_15363747d8cbf71f")) {
    scripted_widgets::set_count(#"hash_15363747d8cbf71f", 0);

    if(delay > 0) {
      wait delay;
    }

    scripted_widgets::remove(#"hash_15363747d8cbf71f");
    scripted_widgets::function_4279fd02(#"computer");
  }
}

function function_f99d2e8a() {
  if(scripted_widgets::exists(#"hash_15363747d8cbf71f") && isDefined(level.var_deff0f73) && level.var_deff0f73.size > 0) {
    for(linenum = 1; linenum <= level.var_deff0f73.size; linenum++) {
      scripted_widgets::function_f2a9266(#"hash_15363747d8cbf71f", linenum, "ContentLine", #"");
      scripted_widgets::function_f2a9266(#"hash_15363747d8cbf71f", linenum, "RussianToLoc", #"");
      scripted_widgets::function_f2a9266(#"hash_15363747d8cbf71f", linenum, "ActiveIndex", -1);
      scripted_widgets::function_f2a9266(#"hash_15363747d8cbf71f", linenum, "MaskText", #"");
      scripted_widgets::function_f2a9266(#"hash_15363747d8cbf71f", linenum, "AutoType", 0);
      scripted_widgets::function_f2a9266(#"hash_15363747d8cbf71f", linenum, "RemoveCursorOnComplete", 0);
      scripted_widgets::function_f2a9266(#"hash_15363747d8cbf71f", linenum, "HideCursor", 0);
      scripted_widgets::function_f2a9266(#"hash_15363747d8cbf71f", linenum, "DrawByLine", 0);
      scripted_widgets::function_f2a9266(#"hash_15363747d8cbf71f", linenum, "ShowNewLineMarker", 0);
      scripted_widgets::function_f2a9266(#"hash_15363747d8cbf71f", linenum, "DrawByLineScreenMax", 0);
      scripted_widgets::function_f2a9266(#"hash_15363747d8cbf71f", linenum, "TypeSpeed", 0);
      scripted_widgets::function_f2a9266(#"hash_15363747d8cbf71f", linenum, "TypingSFXAlias", "");
      scripted_widgets::function_f2a9266(#"hash_15363747d8cbf71f", linenum, "CustomText", #"");
      scripted_widgets::function_f2a9266(#"hash_15363747d8cbf71f", linenum, "AlignTextRight", 0);
      scripted_widgets::function_f2a9266(#"hash_15363747d8cbf71f", linenum, "ClearInlineListOnComplete", 0);
      scripted_widgets::function_f2a9266(#"hash_15363747d8cbf71f", linenum, "FlashHighlight", 0);
      scripted_widgets::function_7239e030(#"hash_15363747d8cbf71f", linenum);
    }

    level.var_deff0f73 = undefined;
  }
}

function private function_66b8c40f(var_c1deb575, linenum) {
  if(scripted_widgets::exists(#"hash_15363747d8cbf71f")) {
    var_6b14e8ab = var_c1deb575.var_f49bdf40;
    var_3bf43333 = var_c1deb575.var_c9d25687;
    MaskText = var_c1deb575.MaskText === 1;
    var_e2b21dfe = var_c1deb575.var_e2b21dfe === 1;
    RemoveCursorOnComplete = var_c1deb575.RemoveCursorOnComplete === 1;
    HideCursor = var_c1deb575.HideCursor === 1;
    DrawByLine = var_c1deb575.DrawByLine === 1;
    AlignTextRight = var_c1deb575.var_4cae1b36 === 1;
    ShowNewLineMarker = var_c1deb575.ShowNewLineMarker === 1;
    DrawByLineScreenMax = var_c1deb575.DrawByLineScreenMax;
    var_fce3a1c3 = var_c1deb575.var_fce3a1c3 === 1;
    FlashHighlight = var_c1deb575.FlashHighlight === 1;

    if(!isDefined(DrawByLineScreenMax)) {
      DrawByLineScreenMax = 0;
    }

    var_3decbda2 = var_c1deb575.var_dabbb2e7;

    if(!isDefined(var_3decbda2)) {
      var_3decbda2 = "";
    }

    if(!isDefined(var_3bf43333)) {
      var_3bf43333 = #"";
    }

    scripted_widgets::function_f2a9266(#"hash_15363747d8cbf71f", linenum, "ContentLine", var_6b14e8ab);
    scripted_widgets::function_f2a9266(#"hash_15363747d8cbf71f", linenum, "RussianToLoc", var_3bf43333);
    scripted_widgets::function_f2a9266(#"hash_15363747d8cbf71f", linenum, "ActiveIndex", linenum);
    scripted_widgets::function_f2a9266(#"hash_15363747d8cbf71f", linenum, "MaskText", MaskText);
    scripted_widgets::function_f2a9266(#"hash_15363747d8cbf71f", linenum, "AutoType", var_e2b21dfe);
    scripted_widgets::function_f2a9266(#"hash_15363747d8cbf71f", linenum, "RemoveCursorOnComplete", RemoveCursorOnComplete);
    scripted_widgets::function_f2a9266(#"hash_15363747d8cbf71f", linenum, "HideCursor", HideCursor);
    scripted_widgets::function_f2a9266(#"hash_15363747d8cbf71f", linenum, "DrawByLine", DrawByLine);
    scripted_widgets::function_f2a9266(#"hash_15363747d8cbf71f", linenum, "ShowNewLineMarker", ShowNewLineMarker);
    scripted_widgets::function_f2a9266(#"hash_15363747d8cbf71f", linenum, "DrawByLineScreenMax", DrawByLineScreenMax);
    scripted_widgets::function_f2a9266(#"hash_15363747d8cbf71f", linenum, "TypeSpeed", 0);
    scripted_widgets::function_f2a9266(#"hash_15363747d8cbf71f", linenum, "ColorIndex", 0);
    scripted_widgets::function_f2a9266(#"hash_15363747d8cbf71f", linenum, "TypingSFXAlias", var_3decbda2);
    scripted_widgets::function_f2a9266(#"hash_15363747d8cbf71f", linenum, "CustomText", #"");
    scripted_widgets::function_f2a9266(#"hash_15363747d8cbf71f", linenum, "AlignTextRight", AlignTextRight);
    scripted_widgets::function_f2a9266(#"hash_15363747d8cbf71f", linenum, "ClearInlineListOnComplete", var_fce3a1c3);
    scripted_widgets::function_f2a9266(#"hash_15363747d8cbf71f", linenum, "FlashHighlight", FlashHighlight);
  }
}