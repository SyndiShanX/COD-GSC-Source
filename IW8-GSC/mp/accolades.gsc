/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\accolades.gsc
***********************************************/

init() {
  level.accolades = [];
  registeraccolade("_encstr_A928091BA95B0A48FBE8D3", ["_encstr_A928091BA95B0A48FBE8D3"], 0, 0, undefined, undefined, undefined);
  registeraccolade("_encstr_81B00D6844C3B7343A28E1194043A0", ["_encstr_81B00D6844C3B7343A28E1194043A0"], 0, 0, undefined, undefined, undefined);
  registeraccolade("_encstr_8A51113065B7E8FEE95705377FB25A40743D5B", ["_encstr_8A51113065B7E8FEE95705377FB25A40743D5B"], 0, 0, undefined, undefined, undefined);
  registeraccolade("_encstr_99D91268D3381C9F365F0AC24085D39C10B114FB", ["_encstr_99D91268D3381C9F365F0AC24085D39C10B114FB"], 0, 0, undefined, undefined, undefined);
  registeraccolade("_encstr_82F313721FF7CA7343232F6138307F551808F20138", ["_encstr_82F313721FF7CA7343232F6138307F551808F20138"], 0, 0, undefined, undefined, undefined);
  registeraccolade("_encstr_B8EE0853B010CFB26116", ["_encstr_B8EE0853B010CFB26116"], 0, 0, undefined, undefined, undefined);
  registeraccolade("_encstr_81880EE74DE64B58D361CBB76C286B73", ["_encstr_81880EE74DE64B58D361CBB76C286B73"], 0, 0, undefined, undefined, undefined);
  registeraccolade("_encstr_ABAB0B8A63871B13AD20BBEFA0", ["_encstr_ABAB0B8A63871B13AD20BBEFA0"], 0, 0, undefined, undefined, undefined);
  registeraccolade("_encstr_A2710D9E486FC3D0E7406FCD473B8B", ["_encstr_A2710D9E486FC3D0E7406FCD473B8B"], 0, 0, ::isclasschoiceallowed, undefined, undefined);
  registeraccolade("_encstr_96D30A3468575BA3C307A128", ["_encstr_96D30A3468575BA3C307A128"], 0, 0, undefined, undefined, undefined);
  registeraccolade("_encstr_A755157338D14277567B067A400DEF7C9A7C7A26F9DA13", ["_encstr_A755157338D14277567B067A400DEF7C9A7C7A26F9DA13"], 0, 0, ::arekillcamsenabled, undefined, undefined);
  registeraccolade("_encstr_9365101BA7930358C5F98289A408DB3A4858", ["_encstr_9365101BA7930358C5F98289A408DB3A4858"], 0, 0, ::arekillcamsenabled, undefined, undefined);
  registeraccolade("_encstr_87F20E78EA85EF89E7449E053AC771BF", ["_encstr_87F20E78EA85EF89E7449E053AC771BF"], 0, 0, undefined, undefined, undefined);
  registeraccolade("_encstr_A3AD0A0598A003AFA2598320", ["_encstr_8E8D0697EB01F243"], 0, 0, undefined, undefined, undefined);
  registeraccolade("_encstr_A3300B380A0687EB47194149FB", ["_encstr_8E8D0697EB01F243"], 0, 1, undefined, undefined, ::scoreminimum);
  registeraccolade("_encstr_92AB0C6B70A3A311736B4CBA80D2", ["_encstr_A1F308589BCD96CD476E"], 0, 0, undefined, undefined, undefined);
  registeraccolade("_encstr_92950D48C9AF47FD9953E33B88ADEB", ["_encstr_A1F308589BCD96CD476E"], 0, 1, undefined, undefined, ::scoreminimum);
  registeraccolade("_encstr_8A880BE357EA900DBF3293183B", ["_encstr_8E0607055DBFB3919A"], 0, 0, undefined, undefined, undefined);
  registeraccolade("_encstr_87140CB1ED0FE37987CAA8083262", ["_encstr_8E0607055DBFB3919A"], 0, 1, undefined, undefined, ::scoreminimum);
  registeraccolade("_encstr_A68209DFE7B79AEC5BF76E", ["_encstr_A68209DFE7B79AEC5BF76E"], 0, 0, undefined, undefined, undefined);
  registeraccolade("_encstr_A3871130254B4831CADFB7F3FBB21D60397B78", ["_encstr_8E8D0697EB01F243", "_encstr_8E0607055DBFB3919A"], 0, 0, undefined, undefined, ::nokillswithdeath_evaluate);
  registeraccolade("_encstr_AA3E0ECDDE2D2D8D3627B788AC58A3A1", ["_encstr_8E8D0697EB01F243", "_encstr_8E0607055DBFB3919A"], 0, 0, undefined, undefined, ::nokillnodeath_evaluate);
  registeraccolade("_encstr_B6570F10DF2B708192025F1D6F3AC9187B", ["_encstr_8E8D0697EB01F243", "_encstr_8E0607055DBFB3919A"], 0, 0, undefined, undefined, ::nokill10deaths_evaluate);
  registeraccolade("_encstr_8F0315DADBDCA3B4B4631B376256B0DC3A882B85D134E6", ["_encstr_8E8D0697EB01F243", "_encstr_8E0607055DBFB3919A"], 0, 0, undefined, undefined, ::mostkillsleastdeaths_evaluate);
  registeraccolade("_encstr_B2BB17C05A7259DC1FACF176955F831114422810734CB7F35F", ["_encstr_8E8D0697EB01F243", "_encstr_96D30A3468575BA3C307A128"], 0, 0, undefined, undefined, ::mostkillsmostheadshots_evaluate);
  registeraccolade("_encstr_91EF17AD7B37A35A2DB18D9B98F63776B2B91D4D8E93B2C2AD", ["_encstr_8E8D0697EB01F243", "_encstr_87F20E78EA85EF89E7449E053AC771BF"], 0, 0, undefined, undefined, ::mostkillslongeststreak_evaluate);
  registeraccolade("_encstr_8CC3105BB41BD8DC268193DB11598547346E", ["_encstr_8E8D0697EB01F243", "_encstr_8E0607055DBFB3919A"], 0, 0, undefined, undefined, ::kills10nodeaths_evaluate);
  registeraccolade("_encstr_83EA11A3FB9F6B40B8D58AD5A8E9956263152B", ["_encstr_83EA11A3FB9F6B40B8D58AD5A8E9956263152B"], 0, 0, undefined, undefined, undefined);
  registeraccolade("_encstr_A940105B4B6363E6199CBD5B24B2865A3746", ["_encstr_A940105B4B6363E6199CBD5B24B2865A3746"], 0, 0, undefined, undefined, undefined);
  registeraccolade("_encstr_B8351310F7A5DAE7A564FBF88AA8729EF0989CAB69", ["_encstr_83EA11A3FB9F6B40B8D58AD5A8E9956263152B"], 0, 1, undefined, undefined, ::nodeathsfrombehind_evaluate);
  registeraccolade("_encstr_AD270D8B6A78E3E34BDF63A433CB83", ["_encstr_AD270D8B6A78E3E34BDF63A433CB83"], 0, 0, undefined, undefined, ::scoreminimum);
  registeraccolade("_encstr_A7A20CB1DE9BD9AC6EA3984B992B", ["_encstr_A7A20CB1DE9BD9AC6EA3984B992B"], 0, 0, undefined, undefined, undefined);
  registeraccolade("_encstr_A7B10CF1BFEA8F782D5FF9717D04", ["_encstr_B2BE0788BAF573592F"], 0, 0, undefined, undefined, undefined);
  registeraccolade("_encstr_A7630C1916DAC2762BA20BB65673", ["_encstr_A7630C1916DAC2762BA20BB65673"], 0, 0, undefined, undefined, undefined);
  registeraccolade("_encstr_848411BBCBA49275908BADAB6040B17A0B6913", ["_encstr_848411BBCBA49275908BADAB6040B17A0B6913"], 0, 0, undefined, undefined, undefined);
  registeraccolade("_encstr_8D6F0F08D7A6D5454B3A2C9757C3036B5B", ["_encstr_8D6F0F08D7A6D5454B3A2C9757C3036B5B"], 0, 0, undefined, undefined, undefined);
  registeraccolade("_encstr_B642089B65A658E8F597", ["_encstr_B642089B65A658E8F597"], 0, 0, ::isreviveenabled, undefined, undefined);
  registeraccolade("_encstr_ACB011A3FF55F7D8CE52E341509EA4F02DACA3", ["_encstr_ACB011A3FF55F7D8CE52E341509EA4F02DACA3"], 0, 0, undefined, undefined, undefined);
  registeraccolade("_encstr_8F8C0D850513CA55CFEB67C95A4D13", ["_encstr_8F8C0D850513CA55CFEB67C95A4D13"], 0, 0, undefined, undefined, undefined);
  registeraccolade("_encstr_812B0DE153B5A0648A2B7F234BC2B6", ["_encstr_812B0DE153B5A0648A2B7F234BC2B6"], 0, 0, undefined, undefined, undefined);
  registeraccolade("_encstr_92090E74BDC19F9DC9D0D358A801D50F", ["_encstr_92090E74BDC19F9DC9D0D358A801D50F"], 0, 0, undefined, undefined, undefined);
  registeraccolade("_encstr_87610E36EDE63BE6347BA32DA51BB1E6", ["_encstr_87610E36EDE63BE6347BA32DA51BB1E6"], 0, 0, undefined, undefined, undefined);
  registeraccolade("_encstr_9BE4105B208BCD83057121569A4CBF15D968", ["_encstr_9BE4105B208BCD83057121569A4CBF15D968"], 0, 0, undefined, undefined, undefined);
  registeraccolade("_encstr_AC3310E07AC707A817C41088ADFFF031ED33", ["_encstr_AC3310E07AC707A817C41088ADFFF031ED33"], 0, 0, undefined, undefined, undefined);
  registeraccolade("_encstr_81730F174029EBDB7923453D0A6B02BCB3", ["_encstr_81730F174029EBDB7923453D0A6B02BCB3"], 0, 0, undefined, undefined, undefined);
  registeraccolade("_encstr_BA3D0E73B8A09F9EC3E04258A801D50F", ["_encstr_BA3D0E73B8A09F9EC3E04258A801D50F"], 0, 0, undefined, undefined, undefined);
  registeraccolade("_encstr_A97813EB838A30079B0AA21DD66F53F32030F3D59A", ["_encstr_A97813EB838A30079B0AA21DD66F53F32030F3D59A"], 0, 0, undefined, undefined, undefined);
  registeraccolade("_encstr_A9F70E8A64FAE19D5EBF48D0436DD12B", ["_encstr_A9F70E8A64FAE19D5EBF48D0436DD12B"], 0, 0, ::iscorempgametype, undefined, undefined);
  registeraccolade("_encstr_82440D73BB3BADE18A902B2F882D19", ["_encstr_82440D73BB3BADE18A902B2F882D19"], 0, 0, ::isnotleanthreadmode, undefined, undefined);
  registeraccolade("_encstr_9AFB0A938AAFA5919267DD33", ["_encstr_9AFB0A938AAFA5919267DD33"], 0, 0, ::isnotleanthreadmode, undefined, undefined);
  registeraccolade("_encstr_924D12DAD07F8B174036E52C5649831799507252", ["_encstr_B1A81263104592BBB74837413915989D6123EAE5"], 0, 0, ::isnotleanthreadmode, undefined, undefined);
  registeraccolade("_encstr_A6DE13865ACE3495373A14D9CE828DD15A1DD59156", ["_encstr_8F691085CECA3985D9B250C6A35A3AAB4695", "_encstr_977C15697BE7028AA7BF0963BB38F37533BA69B7433889"], 0, 0, ::isnotleanthreadmode, undefined, ::highestavgaltitude_evaluate);
  registeraccolade("_encstr_AC181249FF53A03E5368BB8170EB75082B5DD1C3", ["_encstr_8F691085CECA3985D9B250C6A35A3AAB4695", "_encstr_977C15697BE7028AA7BF0963BB38F37533BA69B7433889"], 0, 0, ::isnotleanthreadmode, undefined, ::lowestavgaltitude_evaluate);
  registeraccolade("_encstr_93500B11CD1B017B642AA0A8E3", ["_encstr_93500B11CD1B017B642AA0A8E3"], 0, 0, undefined, undefined, undefined);
  registeraccolade("_encstr_A1260C786A22E9E8BB5BA32944FF", ["_encstr_A1260C786A22E9E8BB5BA32944FF"], 0, 0, undefined, undefined, undefined);
  registeraccolade("_encstr_AF680E8C6F73630E01E0E308F871855F", ["_encstr_AF680E8C6F73630E01E0E308F871855F"], 0, 0, undefined, undefined, undefined);
  registeraccolade("_encstr_A6890DB388305B573845EBC169D81A", ["_encstr_A6890DB388305B573845EBC169D81A"], 0, 0, undefined, undefined, undefined);
  registeraccolade("_encstr_AA2809F3982F54BBA09C28", ["_encstr_AA2809F3982F54BBA09C28"], 0, 0, undefined, undefined, undefined);
  registeraccolade("_encstr_874F0847251A2AD4D0C3", ["_encstr_874F0847251A2AD4D0C3"], 0, 0, undefined, undefined, undefined);
  registeraccolade("_encstr_859C09016D42A72D449380", ["_encstr_859C09016D42A72D449380"], 0, 0, undefined, undefined, undefined);
  registeraccolade("_encstr_AFE80C9BE696E056E45A4B63B1B9", ["_encstr_AFE80C9BE696E056E45A4B63B1B9"], 0, 0, undefined, undefined, undefined);
  registeraccolade("_encstr_A2771083B4DC8EBD8D1256B019B91A7BE8DC", ["_encstr_A2771083B4DC8EBD8D1256B019B91A7BE8DC"], 0, 0, undefined, undefined, undefined);
  registeraccolade("_encstr_922712C92F7B5E03686F7BDB6501B3F024F76B78", ["_encstr_922712C92F7B5E03686F7BDB6501B3F024F76B78"], 0, 0, undefined, undefined, undefined);
  registeraccolade("_encstr_8F79114EEC0219019D5B99F84FA4DB796A93C6", ["_encstr_8F79114EEC0219019D5B99F84FA4DB796A93C6"], 0, 0, undefined, undefined, undefined);
  registeraccolade("_encstr_A5A10D37B69D8459C223B91A7B1DDC", ["_encstr_A5A10D37B69D8459C223B91A7B1DDC"], 0, 0, undefined, undefined, undefined);
  registeraccolade("_encstr_A9E50C61184837F11940A8D573B7", ["_encstr_A9E50C61184837F11940A8D573B7"], 0, 0, undefined, undefined, undefined);
  registeraccolade("_encstr_B8C80DA3CBBC886D08712AF40878A3", ["_encstr_B8C80DA3CBBC886D08712AF40878A3"], 0, 0, undefined, undefined, undefined);
  registeraccolade("_encstr_A9BF1033C8B3CB5780894549F9A05CEF6503", ["_encstr_A9BF1033C8B3CB5780894549F9A05CEF6503"], 0, 0, undefined, undefined, undefined);
  registeraccolade("_encstr_9BF60CB62B1B5995442B853A0D37", ["_encstr_9BF60CB62B1B5995442B853A0D37"], 0, 0, undefined, undefined, undefined);
  registeraccolade("_encstr_8E920DA7E166F320DB91DB73730AAB", ["_encstr_8E920DA7E166F320DB91DB73730AAB"], 0, 0, undefined, undefined, undefined);
  registeraccolade("_encstr_920A0F7CBFA3B3DED1D0D3A8C81BD363DB", ["_encstr_920A0F7CBFA3B3DED1D0D3A8C81BD363DB"], 0, 0, undefined, undefined, undefined);
  registeraccolade("_encstr_B46F0E432830992F07FAF43957CB68EB", ["_encstr_B46F0E432830992F07FAF43957CB68EB"], 0, 0, undefined, undefined, undefined);
  registeraccolade("_encstr_8DEB0A3EE517055BCEDBE030", ["_encstr_8DEB0A3EE517055BCEDBE030"], 0, 0, undefined, undefined, undefined);
  registeraccolade("_encstr_8577097F528803E9B41B28", ["_encstr_8577097F528803E9B41B28"], 0, 0, undefined, undefined, undefined);
  registeraccolade("_encstr_A16A0AD86BEC44CA2C1D349B", ["_encstr_A16A0AD86BEC44CA2C1D349B"], 0, 0, undefined, undefined, undefined);
  registeraccolade("_encstr_82070D105DB4B7F146C9CBDB2953DF", ["_encstr_82070D105DB4B7F146C9CBDB2953DF"], 0, 0, undefined, undefined, undefined);
  registeraccolade("_encstr_8D1D194EA5BD1DA934A5CA63C8112CB60BECB20A899BBDC94C5691", ["_encstr_8D1D194EA5BD1DA934A5CA63C8112CB60BECB20A899BBDC94C5691"], 0, 0, undefined, undefined, undefined);
  registeraccolade("_encstr_A2C11B640B1902BB43404F67B0FF652BFF90AD1E61C368C6CCF0635B98", ["_encstr_A2C11B640B1902BB43404F67B0FF652BFF90AD1E61C368C6CCF0635B98"], 0, 0, ::arekillstreaksallowed, undefined, undefined);
  registeraccolade("_encstr_BD731CA31BA8D51FED93B2FA9856AB4C08E924048BE01A0F95AC4A32809E", ["_encstr_BD731CA31BA8D51FED93B2FA9856AB4C08E924048BE01A0F95AC4A32809E"], 0, 0, ::arekillstreaksallowed, undefined, undefined);
  registeraccolade("_encstr_8B2915B0848C805EAB3B33C3A741BF99799A3B48AAFC9B", ["_encstr_8B2915B0848C805EAB3B33C3A741BF99799A3B48AAFC9B"], 0, 0, ::arekillstreaksallowed, undefined, undefined);
  registeraccolade("_encstr_BA0316ADD2631BCD3A9CCAB05B34AA146514379B5ADCE837", ["_encstr_BA0316ADD2631BCD3A9CCAB05B34AA146514379B5ADCE837"], 0, 0, ::arekillstreaksallowed, undefined, undefined);
  registeraccolade("_encstr_86E81A0FE828C49B598EE79E7A5FF28251899FA7606107222326EFD7", ["_encstr_86E81A0FE828C49B598EE79E7A5FF28251899FA7606107222326EFD7"], 0, 0, ::arekillstreaksallowed, undefined, undefined);
  registeraccolade("_encstr_AFEF1C9B5B605B3A094882DA983FB577FB350A3B6D0B97C4C3A94A02C877", ["_encstr_AFEF1C9B5B605B3A094882DA983FB577FB350A3B6D0B97C4C3A94A02C877"], 0, 0, ::arekillstreaksallowed, undefined, undefined);
  registeraccolade("_encstr_87981DAFDFBA4918FC1239B17CF3287D422F3B9BB7138E4B0C2FE488A5B468", ["_encstr_87981DAFDFBA4918FC1239B17CF3287D422F3B9BB7138E4B0C2FE488A5B468"], 0, 0, ::arekillstreaksallowed, undefined, undefined);
  registeraccolade("_encstr_974519BC48630C6B6DB5DFC7EF8FB26A90737284A090E30249B19F", ["_encstr_974519BC48630C6B6DB5DFC7EF8FB26A90737284A090E30249B19F"], 0, 0, ::arekillstreaksallowed, undefined, undefined);
  registeraccolade("_encstr_B46814FA7070B16FFBBEA3BA4AE94F08B25C78ED993B", ["_encstr_B46814FA7070B16FFBBEA3BA4AE94F08B25C78ED993B"], 0, 0, ::arekillstreaksallowed, undefined, undefined);
  registeraccolade("_encstr_A94919B64B1B36CDA339CA16ADA656E63A9C2F8EAE735A4BC663E6", ["_encstr_A94919B64B1B36CDA339CA16ADA656E63A9C2F8EAE735A4BC663E6"], 0, 0, ::arekillstreaksallowed, undefined, undefined);
  registeraccolade("_encstr_8265185B5A368D371D4ECAC26DAE8659B21BDCED7396A5D88D6E", ["_encstr_8265185B5A368D371D4ECAC26DAE8659B21BDCED7396A5D88D6E"], 0, 0, ::arekillstreaksallowed, undefined, undefined);
  registeraccolade("_encstr_96E31F4A9252217B3B93F74040C80D57E36FE51AE62129C8DA4782B5138FABE0AF", ["_encstr_96E31F4A9252217B3B93F74040C80D57E36FE51AE62129C8DA4782B5138FABE0AF"], 0, 0, ::arekillstreaksallowed, undefined, undefined);
  registeraccolade("_encstr_A19A177BBB80BBDAE968A2FAB875DBFF3C82FDFCD248E325CF", ["_encstr_A19A177BBB80BBDAE968A2FAB875DBFF3C82FDFCD248E325CF"], 0, 0, ::arekillstreaksallowed, undefined, undefined);
  registeraccolade("_encstr_8E2427DA5AD863E63A27560BAD5D345A1DAC41D07B9B1CD0B7E4B75D9B694BD8D8DC826E37B4CD3A37", ["_encstr_8E2427DA5AD863E63A27560BAD5D345A1DAC41D07B9B1CD0B7E4B75D9B694BD8D8DC826E37B4CD3A37"], 0, 0, ::arekillstreaksallowed, undefined, undefined);
  registeraccolade("_encstr_BDA01D9F534A81BF83C26831CFD1F828B7637FFA11DB0E800F4BC8436150CF", ["_encstr_BDA01D9F534A81BF83C26831CFD1F828B7637FFA11DB0E800F4BC8436150CF"], 0, 0, ::arekillstreaksallowed, undefined, undefined);
  registeraccolade("_encstr_BE091E244BD9C27B83808FA7705D28BAB95F2F1A3E43BBA00868C30708D014A3", ["_encstr_BE091E244BD9C27B83808FA7705D28BAB95F2F1A3E43BBA00868C30708D014A3"], 0, 0, ::arekillstreaksallowed, undefined, undefined);
  registeraccolade("_encstr_95281764AFD21093A313920F5A27DF731A5853E9FF5F39BC7B", ["_encstr_95281764AFD21093A313920F5A27DF731A5853E9FF5F39BC7B"], 0, 0, ::arekillstreaksallowed, undefined, undefined);
  registeraccolade("_encstr_B2DD16FA5F91ABF789D599865740CDA9714118F0D9426433", ["_encstr_B2DD16FA5F91ABF789D599865740CDA9714118F0D9426433"], 0, 0, ::arekillstreaksallowed, undefined, undefined);
  registeraccolade("_encstr_9AFA1A708AAB2188137ACB3B9B74707C5FE2EB5892A765116C4CD117", ["_encstr_9AFA1A708AAB2188137ACB3B9B74707C5FE2EB5892A765116C4CD117"], 0, 0, ::arekillstreaksallowed, undefined, undefined);
  registeraccolade("_encstr_88E51C805268E0E77326E788DFB8A3379340206D85202F501FC88C23E05B", ["_encstr_88E51C805268E0E77326E788DFB8A3379340206D85202F501FC88C23E05B"], 0, 0, ::arekillstreaksallowed, undefined, undefined);
  registeraccolade("_encstr_9AB11072A17B4037CBFBC8E0422CDB989343", ["_encstr_9AB11072A17B4037CBFBC8E0422CDB989343"], 0, 0, ::arekillstreaksallowed, undefined, undefined);
  registeraccolade("_encstr_AD8D13A31A30ADC3A583BA30AF0384922F2B90C35B", ["_encstr_AD8D13A31A30ADC3A583BA30AF0384922F2B90C35B"], 0, 0, ::arekillstreaksallowed, undefined, undefined);
  registeraccolade("_encstr_954016DA2DB16337E8935916DA8E39DEEA73322DB48DC6CD", ["_encstr_954016DA2DB16337E8935916DA8E39DEEA73322DB48DC6CD"], 0, 0, ::arekillstreaksallowed, undefined, undefined);
  registeraccolade("_encstr_99EF15628773796E90C3B3726123C8B063817DA7A6E257", ["_encstr_99EF15628773796E90C3B3726123C8B063817DA7A6E257"], 0, 0, ::arekillstreaksallowed, undefined, undefined);
  registeraccolade("_encstr_97200ABE62CF3788B1E98242", ["_encstr_97200ABE62CF3788B1E98242"], 0, 0, undefined, undefined, undefined);
  registeraccolade("_encstr_88C90C37B26BA32B1ED2D263C6CD", ["_encstr_88C90C37B26BA32B1ED2D263C6CD"], 0, 0, undefined, undefined, undefined);
  registeraccolade("_encstr_AC960D25770848B5A0E6995B628C56", ["_encstr_AC960D25770848B5A0E6995B628C56"], 0, 0, undefined, undefined, undefined);
  registeraccolade("_encstr_AA730E6CD80BCBDA7B9C565A5A36D8E6", ["_encstr_AA730E6CD80BCBDA7B9C565A5A36D8E6"], 0, 0, undefined, undefined, undefined);
  registeraccolade("_encstr_AAA91348B883F88B3303778FA5D05E67435F05290B", ["_encstr_AAA91348B883F88B3303778FA5D05E67435F05290B"], 0, 0, undefined, undefined, undefined);
  registeraccolade("_encstr_ACA70EF99339391DEAEF445F13A15906", ["_encstr_ACF908B7A2C0C318EC5A"], 0, 0, undefined, undefined, undefined);
  registeraccolade("_encstr_99560EF3B80573E58821B5933388EDCF", ["_encstr_99560EF3B80573E58821B5933388EDCF"], 0, 0, undefined, undefined, undefined);
  registeraccolade("_encstr_93FE132BB8F73887B0A3647159D853874788726208", ["_encstr_93FE132BB8F73887B0A3647159D853874788726208"], 0, 0, undefined, undefined, undefined);
  registeraccolade("_encstr_B8890E42A897E73420FB2E2FC1107BBF", ["_encstr_B8890E42A897E73420FB2E2FC1107BBF"], 0, 0, undefined, undefined, undefined);
  registeraccolade("_encstr_978F0B1B40F7FCB773BD636DCD", ["_encstr_978F0B1B40F7FCB773BD636DCD"], 0, 0, undefined, undefined, undefined);
  registeraccolade("_encstr_AA78094E598593A3674B2B", ["_encstr_AA78094E598593A3674B2B"], 0, 0, undefined, undefined, undefined);
  registeraccolade("_encstr_AF851178A3D7C371D3481FC7707CB9B3906FCF", ["_encstr_AF851178A3D7C371D3481FC7707CB9B3906FCF"], 0, 0, undefined, undefined, undefined);
  registeraccolade("_encstr_B6960A91CA36F69742D23A37", ["_encstr_B6960A91CA36F69742D23A37"], 0, 0, undefined, undefined, undefined);
  registeraccolade("_encstr_81C008CE0B6E214BD1B9", ["_encstr_81C008CE0B6E214BD1B9"], 0, 0, undefined, undefined, undefined);
  registeraccolade("_encstr_A5910DC36001AB5F38D063F487B53F", ["_encstr_A5910DC36001AB5F38D063F487B53F"], 0, 0, undefined, undefined, undefined);
  registeraccolade("_encstr_994D0C3A40F3FD2BF02B457B4D79", ["_encstr_994D0C3A40F3FD2BF02B457B4D79"], 0, 0, ::arefieldupgradesallowed, undefined, undefined);
  registeraccolade("_encstr_A1DB1015333230A545C3C855DFB5F9508F4F", ["_encstr_A1DB1015333230A545C3C855DFB5F9508F4F"], 0, 0, ::arefieldupgradesallowed, undefined, undefined);
  registeraccolade("_encstr_AF9E0D1F713079F33FEAF51188389A", ["_encstr_AF9E0D1F713079F33FEAF51188389A"], 0, 0, ::arefieldupgradesallowed, undefined, undefined);
  registeraccolade("_encstr_AACD13E6D1DE831C4B9BEC14EDDD2B936996C6B1CD", ["_encstr_AACD13E6D1DE831C4B9BEC14EDDD2B936996C6B1CD"], 0, 0, ::arefieldupgradesallowed, undefined, undefined);
  registeraccolade("_encstr_ACCD11A393F6380D5EA92F37472B6B21D247B9", ["_encstr_ACCD11A393F6380D5EA92F37472B6B21D247B9"], 0, 0, ::arefieldupgradesallowed, undefined, undefined);
  registeraccolade("_encstr_994F1107B1107C21BBD19743375568B9A0387A", ["_encstr_994F1107B1107C21BBD19743375568B9A0387A"], 0, 0, ::arefieldupgradesallowed, undefined, undefined);
  registeraccolade("_encstr_AADE18CB1E2BE8FB62DFB9FBCB4B3593D4F450CD0A8008ACCA8F", ["_encstr_AADE18CB1E2BE8FB62DFB9FBCB4B3593D4F450CD0A8008ACCA8F"], 0, 0, ::arefieldupgradesallowed, undefined, undefined);
  registeraccolade("_encstr_86E11446B2C136DE2F0B4CD82B1AEDEC2B93AAB95646", ["_encstr_86E11446B2C136DE2F0B4CD82B1AEDEC2B93AAB95646"], 0, 0, ::arefieldupgradesallowed, undefined, undefined);
  registeraccolade("_encstr_A55911ADAB37A5A3D2DB37CD09ED87AA9BAC8C", ["_encstr_A55911ADAB37A5A3D2DB37CD09ED87AA9BAC8C"], 0, 0, ::arefieldupgradesallowed, undefined, undefined);
  registeraccolade("_encstr_B1F7085B03F492AE98DB", ["_encstr_B1F7085B03F492AE98DB"], 0, 0, ::isobjectivegametype, undefined, undefined);
  registeraccolade("_encstr_BADE092C37DC5857B1A337", ["_encstr_BADE092C37DC5857B1A337"], 0, 0, ::isobjectivegametype, undefined, undefined);
  registeraccolade("_encstr_A17908687A36275B3B73", ["_encstr_A17908687A36275B3B73"], 0, 0, ::iscarrygametype, undefined, undefined);
  registeraccolade("_encstr_81CF0936850ED1D54EACCD", ["_encstr_81CF0936850ED1D54EACCD"], 0, 0, ::iscapturegametype, undefined, undefined);
  registeraccolade("_encstr_A9F70806677BD37B5EE7", ["_encstr_A9F70806677BD37B5EE7"], 0, 0, ::isctf, undefined, undefined);
  registeraccolade("_encstr_A3B80D06F148AA427D2DEF1F6991AB", ["_encstr_A3B80D06F148AA427D2DEF1F6991AB"], 0, 0, ::iscarrygametype, undefined, undefined);
  registeraccolade("_encstr_97AE0C26DEB5980A8D0BB9D12B19", ["_encstr_8FB00783D8C2CDE8DC"], 0, 0, ::isbombgametype, undefined, undefined);
  registeraccolade("_encstr_92ED0C057F12F6E9B54F738BB79C", ["_encstr_817B0812789D1387E986"], 0, 0, ::isbombgametype, undefined, undefined);
  registeraccolade("_encstr_B2E70E38974569A94A0BB830A6B32351", ["_encstr_8B460D8A6176034A70279C992770D2"], 0, 0, ::isbombgametype, undefined, undefined);
  registeraccolade("_encstr_871B071B63D547B10D", ["_encstr_871B071B63D547B10D"], 0, 0, ::islifelimited, undefined, undefined);
  registeraccolade("_encstr_BA2F0ED8635DA36C344AAC3B4B3B59CD", ["_encstr_BA2F0ED8635DA36C344AAC3B4B3B59CD"], 0, 0, ::isreviveenabled, undefined, undefined);
  registeraccolade("_encstr_97350D34A1D773EBD10B234F43250A", ["_encstr_820E0A2AE8981DBA528588DC"], 0, 0, ::aretagsenabled, undefined, undefined);
  registeraccolade("_encstr_B1C50BA30BCECD44B2735AAC32", ["_encstr_B64E070F391562989D"], 0, 0, ::aretagsenabled, undefined, undefined);
  registeraccolade("_encstr_99C60FE8B0ECB9A6ACEC1609B09B5B9519", ["_encstr_99C60FE8B0ECB9A6ACEC1609B09B5B9519"], 0, 0, ::isgrind, undefined, undefined);
  registeraccolade("_encstr_AF2F10231347ABB4BF03EF5786B5634668DC", ["_encstr_AF2F10231347ABB4BF03EF5786B5634668DC"], 0, 0, ::isgrind, undefined, undefined);
  registeraccolade("_encstr_9A8F0E99A5E4371DA4CD992BB1E8B219", ["_encstr_9A8F0E99A5E4371DA4CD992BB1E8B219"], 0, 0, ::isinfected, undefined, undefined);
  registeraccolade("_encstr_A1500E033302C0C31B3F6D073F629920", ["_encstr_ABEC10F2089925F71D967B552EC3A76B3748"], 0, 0, ::isinfected, undefined, undefined);
  registeraccolade("_encstr_A7580E3473544243136AC7484009E472", ["_encstr_B270105CA8E0EC4BD7974FDB95FD724C2B91"], 0, 0, ::isinfected, undefined, undefined);
  registeraccolade("_encstr_99730D58B61F9B177392500763C0EA", ["_encstr_99730D58B61F9B177392500763C0EA"], 0, 0, ::isinfected, undefined, undefined);
  registeraccolade("_encstr_AD7F0937568E890B1B6D37", ["_encstr_AD7F0937568E890B1B6D37"], 0, 0, ::isgungame, undefined, undefined);
  registeraccolade("_encstr_8A271936DB9BECACB9D18A96B5593583569BD1E9E6D52B58C1DBE6", ["_encstr_8A271936DB9BECACB9D18A96B5593583569BD1E9E6D52B58C1DBE6"], 0, 0, ::isgungame, undefined, undefined);
  registeraccolade("_encstr_BD0515BB679B47D20BD80AA2906B4A875157142506818B", ["_encstr_BD0515BB679B47D20BD80AA2906B4A875157142506818B"], 0, 0, ::arekillstreaksallowed, undefined, undefined);
  registeraccolade("_encstr_B26811626FF1CFB8FF25F9978FA39FDFE34811", ["_encstr_B26811626FF1CFB8FF25F9978FA39FDFE34811"], 0, 0, ::isspawnselectionenabled, undefined, undefined);
  registeraccolade("_encstr_842313B9382CDDDC4D561B566C1D952B869636B156", ["_encstr_842313B9382CDDDC4D561B566C1D952B869636B156"], 0, 0, ::isspawnselectionenabled, undefined, undefined);
  registeraccolade("_encstr_AF2910A03B66AF88073561ED0BA3B551CED2", ["_encstr_AF2910A03B66AF88073561ED0BA3B551CED2"], 0, 0, ::isspawnselectionenabled, undefined, undefined);
  registeraccolade("_encstr_880610D6727A87A833CF3060CF4C65E3235F", ["_encstr_880610D6727A87A833CF3060CF4C65E3235F"], 0, 0, ::isspawnselectionenabled, undefined, undefined);
  registeraccolade("_encstr_B1EB1B91D24D29182F8AC173D24BD97FAB5FA95A7B31651959216305BE", ["_encstr_B1EB1B91D24D29182F8AC173D24BD97FAB5FA95A7B31651959216305BE"], 0, 0, ::isspawnselectionenabled, undefined, undefined);
  registeraccolade("_encstr_B28E123A4BAD954D38CACDE828CD224E96675993", ["_encstr_B28E123A4BAD954D38CACDE828CD224E96675993"], 0, 0, ::arevehiclesenabled, undefined, undefined);
  registeraccolade("_encstr_86A315E388113F7A3073AEBC5340F27746634ACAD1FDAB", ["_encstr_86A315E388113F7A3073AEBC5340F27746634ACAD1FDAB"], 0, 0, ::arevehiclesenabled, undefined, undefined);
  registeraccolade("_encstr_AAF01AFBF06F6816DE36A85DF881835D6119883C2B5B8A71189F8562", ["_encstr_AAF01AFBF06F6816DE36A85DF881835D6119883C2B5B8A71189F8562"], 0, 0, ::arevehiclesenabled, undefined, undefined);
  registeraccolade("_encstr_85C90CBDE13F210F0D99D8E052A3", ["_encstr_ACF5089FF6827199725B"], 0, 0, ::ishardpoint, undefined, undefined);
}

registeraccolade(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  var_7 = spawnStruct();
  var_7.datapoints = var_1;
  var_7.priority = var_2;
  var_7.intialvalueisvalid = var_3;
  var_7.evaluatefunc = var_6;
  var_7.winners = [];
  var_7.isactive = !isDefined(var_4) || [[var_4]]();
  level.accolades[var_0] = var_7;

  if(isDefined(var_5))
    level thread[[var_5]]();
}

applyaccoladestructtoplayerpers() {
  var_0 = scripts\mp\utility\game::onlinestatsenabled();

  foreach(var_6, var_2 in level.accolades) {
    if(var_0)
      self setplayerdata("_encstr_8C07031599", "_encstr_A7A20CC1D8585EAC4E9AE80B1D9B", "_encstr_AD750FB9564BCF084177E89053B9410B83", var_6, 0);

    if(!isDefined(var_2.datapoints)) {
      continue;
    }
    foreach(var_4 in var_2.datapoints)
    scripts\mp\utility\stats::initpersstat(var_4);
  }
}

obj_riverbed() {
  if(!istrue(level.challengesallowed)) {
    return;
  }
  foreach(var_2, var_1 in level.accolades) {
    if(!var_1.isactive) {
      continue;
    }
    level evaluateaccolade(var_2);
  }

  if(scripts\mp\utility\game::onlinestatsenabled()) {
    foreach(var_2, var_1 in level.accolades) {
      if(!var_1.isactive) {
        continue;
      }
      foreach(var_5 in var_1.winners) {
        if(!isDefined(var_5)) {
          continue;
        }
        var_6 = var_5 getplayerdata("_encstr_8C07031599", "_encstr_A7A20CC1D8585EAC4E9AE80B1D9B", "_encstr_96950EB08D8D7BB1588C59D43A58D1E6", var_2);
        var_5 setplayerdata("_encstr_8C07031599", "_encstr_A7A20CC1D8585EAC4E9AE80B1D9B", "_encstr_96950EB08D8D7BB1588C59D43A58D1E6", var_2, var_6 + 1);
        var_5 setplayerdata("_encstr_8C07031599", "_encstr_A7A20CC1D8585EAC4E9AE80B1D9B", "_encstr_AD750FB9564BCF084177E89053B9410B83", var_2, 1);
      }
    }
  }
}

evaluateaccolade(var_0) {
  var_1 = undefined;

  foreach(var_3 in level.players) {
    if(!isDefined(var_3)) {
      continue;
    }
    var_4 = var_3.pers[var_0];

    if(isDefined(level.accolades[var_0].evaluatefunc))
      var_4 = var_3[[level.accolades[var_0].evaluatefunc]](var_0);
    else
      var_4 = var_3.pers[level.accolades[var_0].datapoints[0]];

    if(!isDefined(var_4) || !level.accolades[var_0].intialvalueisvalid && var_4 == 0) {
      continue;
    }
    if(!isDefined(var_1) || var_4 > var_1) {
      var_1 = var_4;
      level.accolades[var_0].winners = [];
      level.accolades[var_0].winners[level.accolades[var_0].winners.size] = var_3;
      continue;
    }

    if(var_4 == var_1)
      level.accolades[var_0].winners[level.accolades[var_0].winners.size] = var_3;
  }
}

arekillcamsenabled() {
  return istrue(level.killcam);
}

isnotleanthreadmode() {
  return !scripts\mp\utility\game::runleanthreadmode();
}

isclasschoiceallowed() {
  scripts\mp\flags::gameflagwait("_encstr_93DB1596E666B436BE6E59D1EAE0AF8DF6AD836359A32B");
  return scripts\mp\utility\game::allowclasschoice();
}

islifelimited() {
  return istrue(level.numlifelimited);
}

isreviveenabled() {
  return istrue(level.numrevives);
}

iscorempgametype() {
  return scripts\mp\utility\game::getgametype() != "_encstr_B607038AAB";
}

arekillstreaksallowed() {
  return istrue(level.allowkillstreaks);
}

arefieldupgradesallowed() {
  return istrue(level.allowsupers);
}

isobjectivegametype() {
  return scripts\mp\utility\game::getgametype() != "_encstr_B41904BB8593" && scripts\mp\utility\game::getgametype() != "_encstr_9707038CB6" && scripts\mp\utility\game::getgametype() != "_encstr_B607038AAB";
}

isbombgametype() {
  return scripts\mp\gameobjects::isbombmode();
}

iscarrygametype() {
  if(scripts\mp\gameobjects::isbombmode())
    return 1;

  switch (scripts\mp\utility\game::getgametype()) {
    case "_encstr_85EF050CB150E7":
    case "_encstr_8E1904B3F501":
      return 1;
  }

  return 0;
}

iscapturegametype() {
  switch (scripts\mp\utility\game::getgametype()) {
    case "_encstr_9A7205B39CB919":
    case "_encstr_A7290676E4D2378C":
    case "_encstr_BDD705AD7BD143":
    case "_encstr_8E07030349":
    case "_encstr_A54F06D32A2F0498":
    case "_encstr_8218041DF5FA":
    case "_encstr_A9B606B0C956B916":
    case "_encstr_B81904B04E6B":
      return 1;
  }

  return 0;
}

isctf() {
  return scripts\mp\utility\game::getgametype() == "_encstr_8E1904B3F501";
}

isspawnselectionenabled() {
  return istrue(level.usespawnselection);
}

aretagsenabled() {
  return istrue(level.dogtagsenabled);
}

isgrind() {
  return scripts\mp\utility\game::getgametype() == "_encstr_A7290676E4D2378C";
}

isinfected() {
  return scripts\mp\utility\game::getgametype() == "_encstr_AAE507E8423F63C163";
}

isgungame() {
  return scripts\mp\utility\game::getgametype() == "_encstr_8A1804DAAB75";
}

ishardpoint() {
  return scripts\mp\utility\game::getgametype() == "_encstr_BDD705AD7BD143" || scripts\mp\utility\game::getgametype() == "_encstr_9A7205B39CB919";
}

arevehiclesenabled() {
  return getdvarint("_encstr_87EF136FB8EBF7BA6981651B6035B298D010ABBFA0", 0) == 1;
}

scoreminimum(var_0) {
  return self.pers[level.accolades[var_0].datapoints[0]] * -1;
}

nokillswithdeath_evaluate(var_0) {
  if(self.pers["_encstr_8E8D0697EB01F243"] == 0 && self.pers["_encstr_8E0607055DBFB3919A"] > 0)
    return 1;

  return 0;
}

nokillnodeath_evaluate(var_0) {
  if(self.pers["_encstr_8E8D0697EB01F243"] == 0 && self.pers["_encstr_8E0607055DBFB3919A"] == 0)
    return 1;

  return 0;
}

nokill10deaths_evaluate(var_0) {
  if(self.pers["_encstr_8E8D0697EB01F243"] == 0 && self.pers["_encstr_8E0607055DBFB3919A"] >= 10)
    return 1;

  return 0;
}

mostkillsleastdeaths_evaluate(var_0) {
  var_1 = scripts\engine\utility::array_contains(level.accolades["_encstr_A3AD0A0598A003AFA2598320"].winners, self);
  var_2 = scripts\engine\utility::array_contains(level.accolades["_encstr_87140CB1ED0FE37987CAA8083262"].winners, self);

  if(var_1 && var_2)
    return 1;

  return 0;
}

mostkillsmostheadshots_evaluate(var_0) {
  var_1 = scripts\engine\utility::array_contains(level.accolades["_encstr_A3AD0A0598A003AFA2598320"].winners, self);
  var_2 = scripts\engine\utility::array_contains(level.accolades["_encstr_96D30A3468575BA3C307A128"].winners, self);

  if(var_1 && var_2)
    return 1;

  return 0;
}

mostkillslongeststreak_evaluate(var_0) {
  var_1 = scripts\engine\utility::array_contains(level.accolades["_encstr_A3AD0A0598A003AFA2598320"].winners, self);
  var_2 = scripts\engine\utility::array_contains(level.accolades["_encstr_87F20E78EA85EF89E7449E053AC771BF"].winners, self);

  if(var_1 && var_2)
    return 1;

  return 0;
}

kills10nodeaths_evaluate(var_0) {
  if(self.pers["_encstr_8E8D0697EB01F243"] >= 10 && self.pers["_encstr_8E0607055DBFB3919A"] == 0)
    return 1;

  return 0;
}

nodeathsfrombehind_evaluate(var_0) {
  if(self.pers["_encstr_83EA11A3FB9F6B40B8D58AD5A8E9956263152B"] == 10)
    return 1;

  return 0;
}

highestavgaltitude_evaluate(var_0) {
  if(self.pers["_encstr_977C15697BE7028AA7BF0963BB38F37533BA69B7433889"] > 0)
    return self.pers["_encstr_8F691085CECA3985D9B250C6A35A3AAB4695"] / self.pers["_encstr_977C15697BE7028AA7BF0963BB38F37533BA69B7433889"];
  else
    return 0;
}

lowestavgaltitude_evaluate(var_0) {
  if(self.pers["_encstr_977C15697BE7028AA7BF0963BB38F37533BA69B7433889"] > 0)
    return self.pers["_encstr_8F691085CECA3985D9B250C6A35A3AAB4695"] / self.pers["_encstr_977C15697BE7028AA7BF0963BB38F37533BA69B7433889"] * -1;
  else
    return 0;
}