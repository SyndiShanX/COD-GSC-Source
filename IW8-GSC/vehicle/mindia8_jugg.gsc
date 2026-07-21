/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: vehicle\mindia8_jugg.gsc
***********************************************/

#using_animtree("_encstr_A35F099B8B0BAA5B5081FA");

main(var_0, var_1, var_2) {
  scripts\common\vehicle_build::build_template("_encstr_88520840BAB5F918BF78", var_0, var_1, var_2);
  scripts\common\vehicle_build::build_localinit(::init_local);
  scripts\common\vehicle_build::build_deathmodel("_encstr_A38024ECAC0DC1D75BB41BEB585A93D75B5A37C8961607AFDE072BDCAF13C21B5B7D77B6D7C3");
  scripts\common\vehicle_build::build_deathfx("_encstr_8AF621C466E3E0CFD533305A7A28A1C0E60F4E35F62F311BBF7B90D10207B5B967BCD5", "_encstr_BE48103A2C3BFA95733B4BE62BD7B1CA333A", "_encstr_8736143C085044E923DBBBA73F58E3ACE0F37984A0D8", undefined, undefined, undefined, 0.2, 1, undefined);

  if(scripts\common\utility::iscp() && isDefined(level._id_12D73))
    scripts\common\vehicle_build::build_rocket_deathfx(level._id_12D73, "_encstr_A2B40B8E2C3B7DDB274B9D4B37", "_encstr_AF73140D3BFB572AB79A176E47087BED9A49EE15DD05", undefined, undefined, 0, 0, 1, undefined);

  scripts\common\vehicle_build::build_deathfx("_encstr_8AF621C466E3E0CFD533305A7A28A1C0E60F4E35F62F311BBF7B90D10207B5B967BCD5", "_encstr_A25B0F90226CE1D68B2775E01217385D93", "_encstr_9BC71EF31FE82D712419E8CB4217290BF183110F0AEAF758830902F739B7D0D1", undefined, undefined, undefined, 0.5, 1, undefined);
  scripts\common\vehicle_build::build_deathfx("_encstr_BED121DB74B9BE33B8C8F7D65872F852FF9CE4526D4F3375C018CF0F28EBA14A21B82D", "_encstr_A25B0F90226CE1D68B2775E01217385D93", "_encstr_A1C61B2410485CC11BE393BFD7B0FB84C89B11AF8AD8EE1AF89997AF19", 1, 0.05, 1, 0.5, 1, undefined);
  scripts\common\vehicle_build::build_treadfx();
  scripts\common\vehicle_build::build_treadfx(var_2, "_encstr_8B1608EC43B8D647A113", "_encstr_A2F42585F3EBF868176729688BD28007826E313BB382881825BAF37EB7ADD04F4B8BB12543DAE3", 1);
  scripts\common\vehicle_build::build_life(3000, 2800, 3100);
  scripts\common\vehicle_build::build_team("_encstr_8E8405EA382B2A");
  scripts\common\vehicle_build::build_aianims(::setanims, ::set_vehicle_anims, "_encstr_84AB069378304D32");
  var_3 = randomfloatrange(0, 1);
  scripts\common\vehicle_build::build_unload_groups(::unload_groups);
  scripts\common\vehicle_build::build_bulletshield(1);
  scripts\common\vehicle_build::build_is_helicopter();
  scripts\common\vehicle_build::build_drive(%_encstr_8C9A0CD64B1983D793F61DDEE46E, undefined, 0, 3.0);
}

init_local() {
  self.vehicleanimalias = "_encstr_A9100DDA2D37325A161C7D53D59DCE";
  self.unload_hover_offset = 170;
  self.skipdeathanim = 1;
  self.script_badplace = 1;
  scripts\common\vehicle::vehicle_lights_on("_encstr_92B408E4D573DCD2CDEC");
}

#using_animtree("_encstr_A5AD0EDA0198272AF00797B83388B643");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");

setanims() {
  var_0 = [];

  for(var_1 = 0; var_1 < 15; var_1++)
    var_0[var_1] = spawnStruct();

  var_0[0].idle = % _encstr_AFB4168310E1758238C1A77F8148DBB9A058BB41A8500C1A;
  var_0[0].idle_anim = "_encstr_AFB4168310E1758238C1A77F8148DBB9A058BB41A8500C1A";
  var_0[1].idle = % _encstr_820D187B6B110BBA4EC7E8D972B9F1E22082828790F7A0444195;
  var_0[1].idle_anim = "_encstr_820D187B6B110BBA4EC7E8D972B9F1E22082828790F7A0444195";
  var_0[2].idle = % _encstr_A31A23E6239C7D6BE0EBEC591AD7AD5ACDC84B58C1FA9D9C7BD5378CAF993998FA4B46B1B2;
  var_0[3].idle = % _encstr_831823DFAB4317B172277BDFC0FE4974808D6109124FA750D0CB9059BF0586E6E953D7D1BD;
  var_0[4].idle = % _encstr_A9B02337C8C9AF6B0EAFB3561ABEB55AE632960B83D7EC27BDEAE6C8F5CC3999D7B4321B95;
  var_0[5].idle = % _encstr_ADC12313A9F0B1DF579E1BD2803817F4C801B18989F1C7FBF0F392CA4E8613BAE9E3341C5B;
  var_0[6].idle = % _encstr_86DA23B98CE4F56B07BED9B2A1BEB65A73C8D2C21CD7CE937B577332EB4EE446F5A5913659;
  var_0[7].idle = % _encstr_A6BD234E997E8122E3114B5FA07E28587B4C389E510181DD9F6D3507F7E636CB5FD85590AA;
  var_0[8].idle = % _encstr_95CE236E46C9D7AD1CF53B5634D7B64BCD8C2D0B07FAD9C9F6ABCD8CEB33D826FA968CB12B;
  var_0[9].idle = % _encstr_A94F23B9C839D75B0EFACE590DF56B5ADC8CA5B00EBE9D27EDAECD19FA668D91AF968CC656;
  var_0[10].idle = % _encstr_AD33239B234EF55BC1BE3B9543F55BB47332D22C70FA769C7B5DE619D7CC3633D72D32D859;
  var_0[11].idle = % _encstr_97DA23826D8591056389A317C87ECD3A65F58CBEEBB76A42A8F0CB1B59F3B4E7AF9B57753D;
  var_0[12].idle = % _encstr_81B0230B07CBF93538F90815608F501BD5C9236140E16F250705D809B8DD633F49989B685D;
  var_0[13].idle = % _encstr_AB49237F90FBE76A2168538FEB572269C0388FBF8AB617A347155DC758F5EA7B8EC83373C8;
  var_0[14].idle = % _encstr_914323DFC3BB6F72F756CBAB49E7E7CB7DFDF1C36A8E1FAD4275960D61D36B1417BAB929EB;
  var_0[0].sittag = "_encstr_9AD01136187923E791B06F67D06B9509DD203B";
  var_0[1].sittag = "_encstr_9AD01136187923E791B06F67D06B9509DD203B";
  var_0[2].sittag = "_encstr_A10109A316D9F5ECBAF298";
  var_0[3].sittag = "_encstr_93010973A849F7DA5B0B32";
  var_0[4].sittag = "_encstr_A30109412FDAAF88CDE0A3";
  var_0[5].sittag = "_encstr_8F0109E858D9FA76BACB0D";
  var_0[6].sittag = "_encstr_9101096BBF4A4F97FB983D";
  var_0[7].sittag = "_encstr_AC0109244BFFEEA19D7293";
  var_0[8].sittag = "_encstr_B801093B97E7D9579BF09E";
  var_0[9].sittag = "_encstr_8D01091D589DFA9D5DBCE0";
  var_0[10].sittag = "_encstr_A50109A316CEFA9DD5CB27";
  var_0[11].sittag = "_encstr_8ED60A354FE127D86388D3AF";
  var_0[12].sittag = "_encstr_B8D60AC0E3E4780FFB836EE7";
  var_0[13].sittag = "_encstr_92D60A71F94F693C5F135B33";
  var_0[14].sittag = "_encstr_9AD01136187923E791B06F67D06B9509DD203B";
  var_0[2].getout = % _encstr_8AF6234664CBEED312E1A808AAE19B60E30CC337A0D751353DAB6008B1C79DB3CFB5D3BB44;
  var_0[3].getout = % _encstr_8A362337D8B35FD2E9A08B47138FEA219840D707524EDFEB3F4D953F909553A246E00BAF88;
  var_0[4].getout = % _encstr_8D4B23CD919CF5D607FA3BCA1AD7B62D378CA55807AFCE93ED57B923F5669C33EBACF0A5E8;
  var_0[5].getout = % _encstr_815C235F2B9B10A8B8191B71FCAF90B3F2B3E383B291C418CFEBCD69296AA0D7991F591B3B;
  var_0[6].getout = % _encstr_8CB723378C27D7AD837D9D5943FADA4B37322D58E0BE9D4E7BEAE632AF274E64F5CAE15AD1;
  var_0[7].getout = % _encstr_852223F3E025690FBBAFDEC5A366372CB578DA2AEAA7DF3B307DDEFCD02B83E2AFD8532230;
  var_0[8].getout = % _encstr_B8ED2357B8D3FF7249AF2BE7F36F0A813820B7A7F2AE3F4B5F2D35DF7035D201A6406B0F68;
  var_0[9].getout = % _encstr_852C23FB44FB579A20E14C975CAF0D91C21508B7C11F878B585BADD8D1F9889ACF97F3C1D3;
  var_0[10].getout = % _encstr_A7972366C7FB6778A0B7709013F73043626FD3E748C1EF439737B890E7E6E82FD957D37BB3;
  var_0[11].getout = % _encstr_B43F23C2918847C237B7DB6F21480AB9B039FCCE8289076B80CBB363678662B991E1305463;
  var_0[12].getout = % _encstr_84CF23B3C7921951EB8F15CBABE1A960565F784978D7A096320F2DC15F1B61E2CFF7C2C013;
  var_0[13].getout = % _encstr_83E4236713A328E0E0415309B4E7A87B3A7B2BCBFAD98CC0072358211192988EC1C7814363;
  var_0[14].getout = % _encstr_A378230F098649D530463BC79871EDE25091EFBF59B87282A06B358F96303D5AA03B331779;
  var_0[2].getoutstance = "_encstr_B13D076BED70539F23";
  var_0[3].getoutstance = "_encstr_B13D076BED70539F23";
  var_0[4].getoutstance = "_encstr_B13D076BED70539F23";
  var_0[5].getoutstance = "_encstr_B13D076BED70539F23";
  var_0[6].getoutstance = "_encstr_B13D076BED70539F23";
  var_0[7].getoutstance = "_encstr_B13D076BED70539F23";
  var_0[8].getoutstance = "_encstr_B13D076BED70539F23";
  var_0[9].getoutstance = "_encstr_B13D076BED70539F23";
  var_0[10].getoutstance = "_encstr_B13D076BED70539F23";
  var_0[11].getoutstance = "_encstr_B13D076BED70539F23";
  var_0[12].getoutstance = "_encstr_B13D076BED70539F23";
  var_0[13].getoutstance = "_encstr_B13D076BED70539F23";
  var_0[14].getoutstance = "_encstr_A5AD069B231F0BAF";
  return var_0;
}

#using_animtree("_encstr_A35F099B8B0BAA5B5081FA");

set_vehicle_anims(var_0) {
  for(var_1 = 0; var_1 < var_0.size; var_1++)
    var_0[var_1].vehicle_getoutanim = % _encstr_A96F1A3BECA7E8C992BFD3A7EB3A0FC035458670D7CCF8689A3BD7C1;

  return var_0;
}

unload_groups() {
  var_0 = [];
  var_0["_encstr_9B5A0A96F7BA4D4ECC0FA028"] = [3, 4, 5];
  var_0["_encstr_8C510B39590BE4BE4EB4EC0D3A"] = [6, 7, 8];
  var_0["_encstr_AB0A0B99C9DBB98EAFC69533E8"] = [9, 10, 11];
  var_0["_encstr_8FEE0C6E10B7CB6067CD678F0CE3"] = [12, 13, 14];
  var_0["_encstr_AF1904A7F929"] = [2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14];
  var_0["_encstr_8B1608EC43B8D647A113"] = var_0["_encstr_AF1904A7F929"];
  return var_0;
}