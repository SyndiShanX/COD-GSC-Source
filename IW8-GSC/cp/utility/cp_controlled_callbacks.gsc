/**************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: cp\utility\cp_controlled_callbacks.gsc
**************************************************/

_id_12EC3(var_0) {
  var_1 = getdvarint("_encstr_8E752DE842EAC7314BD73F27FF7B1B25528A48016A05F3282715BBA7D46F83DBFDA299C8425D23434F2ACF95B92F4B", 500);
  var_2 = getdvarint("_encstr_8DE22D6E369CFA13C9AF160BEBD1EA4EE4CAD17DCC36165BF559E107D8DBDCB47BB9D7F6BAA3569CD74E858C4BEA6E", 1000);
  var_3 = getdvarint("_encstr_B4262F173E8231E57290030F47AB0312BBF5B899CBF0237FC14ECF025B7771B7811158D05618E588FEA7DBEBC6313739E8", 100);
  var_4 = getdvarint("_encstr_A6262FB9B1E4BE13C9EBB02CBE3AEA2739CAA3FA99C616DAF567AC0D968D1B2BFA8C58B5C2CE95BE4C7B9B5DE6FA6BC23C", 200);
  var_5 = getdvarint("_encstr_81EC39CD36C9FA899CD78516F51DAEE44EACE8BE9936B0ADFA16A527C69C8533D1EBC82C6B167659BE4CDB9BAB37AF161923A5E8963B59F5B65AB9", 100);
  var_6 = getdvarint("_encstr_A3EC394B867B4FB6CDD90A02F1E9AB23937DB4EFAC8DFFBCEF30B22BE83DE63B0BC82C49B1C95FC7C740DAE2705751DFA1CDB9D4DBF39F017B60B3", 200);
  var_7 = getdvarint("_encstr_95E8396ED8E47D2693D72CB0F53AAB394EAC3A7D99B1B06DBE0B96FAB03B2BDC47AF8C2CD658D959AF13F69B576ED71623234B1D96D92BEBB5B4B9", 25);
  var_8 = getdvarint("_encstr_86E8396FB8EBF78A5518E69E6031B382B320CB5708C001C2372FEC1957CF4A56DB890337B8D97F6ADFB6754D45CFA1E121F8AFEB2053B5F1E3DFB8", 50);
  var_9 = getdvarint("_encstr_BEDE27C399CE876690B771799F886B8B76F12B8941A9371C21117A4FED78B65B1348B2F14B7FFFD790", 550);
  var_10 = getdvarfloat("_encstr_9A312A9BAA021FE963EF070F9703730D6A52B0D9525D9B6DFFE896708A6F79D914AAA0510AB4DD998BE9117D", 2.0);
  var_11 = getdvarfloat("_encstr_ACF52EA7769A6792832FFF61888BD863786DC549FA14DFC0672250F8AA81EF3C6A4973EF1DB919C71C786B3217D693D1", 1);
  var_12 = getdvarfloat("_encstr_B4143808A20A27D16BF71F079F1B7B0572AAA8E14A25930807E09E08B26761C11CA2A859F3FAC381C327AE779CAB6897835AE0D16B560378AF12", 35);
  var_13 = var_9 * var_10 * var_11 * var_12;
  var_14 = var_13 * 0.5;
  var_15 = getdvarfloat("_encstr_AFA3280BD15B56D05AB9DAB7D1FC63D08B8BD32F41F23F54694844FE37956932D84FA00943A3EFC41AA8", 0.5);
  var_16 = self;
  var_17 = var_0.attacker;
  var_18 = var_0.damage;
  var_19 = var_0.point;
  var_20 = distance(var_19, var_17.origin);
  var_21 = 1;

  if(var_20 > var_14)
    var_21 = var_15 + (1 - var_15) * (1 - (var_20 - var_14) / (var_13 - var_14));

  var_22 = 0;
  var_23 = distance(var_16.origin, var_19);

  if(var_23 <= var_1) {
    if(var_16 scripts\cp_mp\vehicles\vehicle::isvehicle()) {
      var_22 = var_4;

      if(isDefined(var_16.vehiclename)) {
        switch (var_16.vehiclename) {
          case "_encstr_83F40783ADF1D14AA3":
          case "_encstr_BDC80A5437EAD749519A6068":
          case "_encstr_9A8F0CB1A5E8471BB2EB894B39C8":
            var_22 = var_22 + var_6;
        }
      }
    } else if(isai(var_16))
      var_22 = var_22 + var_8;
  } else {
    var_24 = (var_23 - var_1) / (var_2 - var_1);
    var_22 = var_24 * (var_4 - var_3) + var_3;

    if(var_16 scripts\cp_mp\vehicles\vehicle::isvehicle()) {
      if(isDefined(var_16.vehiclename)) {
        switch (var_16.vehiclename) {
          case "_encstr_83F40783ADF1D14AA3":
          case "_encstr_BDC80A5437EAD749519A6068":
          case "_encstr_9A8F0CB1A5E8471BB2EB894B39C8":
            var_22 = var_22 + (var_24 * (var_6 - var_5) + var_5);
        }
      }
    } else if(isai(var_16))
      var_22 = var_22 + (var_24 * (var_8 - var_7) + var_7);
  }

  var_22 = var_22 * var_21;
  return int(var_18 + var_22);
}