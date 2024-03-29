//
//  UIFont+PingFang.swift
//  YSTools-Swift
//
//  Created by Joseph Koh on 2019/6/4.
//  Copyright © 2019 Joseph Koh. All rights reserved.
//

import UIKit

@objc extension UIFont {
    
    @objc public class func pingFangFont(ofSize fontSize: CGFloat) -> UIFont {
        return UIFont(name: "PingFangSC-Regular", size: fontSize) ?? UIFont.systemFont(ofSize: fontSize)
    }
 
    @objc public class func mediumPingFangFont(ofSize fontSize: CGFloat) -> UIFont {
        return UIFont(name: "PingFangSC-Medium", size: fontSize) ?? UIFont.boldSystemFont(ofSize: fontSize)
    }
    
    @objc public class func boldPingFangFont(ofSize fontSize: CGFloat) -> UIFont {
        return UIFont(name: "PingFangSC-Bold", size: fontSize) ?? UIFont.boldSystemFont(ofSize: fontSize)
    }
}

/*
 for fontfamilyname in UIFont.familyNames {
     print("fontfamilyname: \(fontfamilyname))")
     for fontname in UIFont.fontNames(forFamilyName: fontfamilyname) {
         print("fontname: \(fontname))")
     }
 }
 */


/*
 Font: Copperplate-Light
 Font: Copperplate
 Font: Copperplate-Bold
 Font: AppleSDGothicNeo-Thin
 Font: AppleSDGothicNeo-Light
 Font: AppleSDGothicNeo-Regular
 Font: AppleSDGothicNeo-Bold
 Font: AppleSDGothicNeo-SemiBold
 Font: AppleSDGothicNeo-UltraLight
 Font: AppleSDGothicNeo-Medium
 Font: Thonburi
 Font: Thonburi-Light
 Font: Thonburi-Bold
 Font: GillSans-Italic
 Font: GillSans-SemiBold
 Font: GillSans-UltraBold
 Font: GillSans-Light
 Font: GillSans-Bold
 Font: GillSans
 Font: GillSans-SemiBoldItalic
 Font: GillSans-BoldItalic
 Font: GillSans-LightItalic
 Font: MarkerFelt-Thin
 Font: MarkerFelt-Wide
 Font: HiraMaruProN-W4
 Font: CourierNewPS-ItalicMT
 Font: CourierNewPSMT
 Font: CourierNewPS-BoldItalicMT
 Font: CourierNewPS-BoldMT
 Font: KohinoorTelugu-Regular
 Font: KohinoorTelugu-Medium
 Font: KohinoorTelugu-Light
 Font: AvenirNextCondensed-Heavy
 Font: AvenirNextCondensed-MediumItalic
 Font: AvenirNextCondensed-Regular
 Font: AvenirNextCondensed-UltraLightItalic
 Font: AvenirNextCondensed-Medium
 Font: AvenirNextCondensed-HeavyItalic
 Font: AvenirNextCondensed-DemiBoldItalic
 Font: AvenirNextCondensed-Bold
 Font: AvenirNextCondensed-DemiBold
 Font: AvenirNextCondensed-BoldItalic
 Font: AvenirNextCondensed-Italic
 Font: AvenirNextCondensed-UltraLight
 Font: TamilSangamMN
 Font: TamilSangamMN-Bold
 Font: HelveticaNeue-UltraLightItalic
 Font: HelveticaNeue-Medium
 Font: HelveticaNeue-MediumItalic
 Font: HelveticaNeue-UltraLight
 Font: HelveticaNeue-Italic
 Font: HelveticaNeue-Light
 Font: HelveticaNeue-ThinItalic
 Font: HelveticaNeue-LightItalic
 Font: HelveticaNeue-Bold
 Font: HelveticaNeue-Thin
 Font: HelveticaNeue-CondensedBlack
 Font: HelveticaNeue
 Font: HelveticaNeue-CondensedBold
 Font: HelveticaNeue-BoldItalic
 Font: GurmukhiMN-Bold
 Font: GurmukhiMN
 Font: Georgia-BoldItalic
 Font: Georgia-Italic
 Font: Georgia
 Font: Georgia-Bold
 Font: TimesNewRomanPS-ItalicMT
 Font: TimesNewRomanPS-BoldItalicMT
 Font: TimesNewRomanPS-BoldMT
 Font: TimesNewRomanPSMT
 Font: SinhalaSangamMN-Bold
 Font: SinhalaSangamMN
 Font: ArialRoundedMTBold
 Font: Kailasa-Bold
 Font: Kailasa
 Font: KohinoorDevanagari-Regular
 Font: KohinoorDevanagari-Light
 Font: KohinoorDevanagari-Semibold
 Font: KohinoorBangla-Regular
 Font: KohinoorBangla-Semibold
 Font: KohinoorBangla-Light
 Font: ChalkboardSE-Bold
 Font: ChalkboardSE-Light
 Font: ChalkboardSE-Regular
 Font: AppleColorEmoji
 Font: PingFangTC-Regular
 Font: PingFangTC-Thin
 Font: PingFangTC-Medium
 Font: PingFangTC-Semibold
 Font: PingFangTC-Light
 Font: PingFangTC-Ultralight
 Font: GujaratiSangamMN
 Font: GujaratiSangamMN-Bold
 Font: GeezaPro-Bold
 Font: GeezaPro
 Font: DamascusBold
 Font: DamascusLight
 Font: Damascus
 Font: DamascusMedium
 Font: DamascusSemiBold
 Font: Noteworthy-Bold
 Font: Noteworthy-Light
 Font: Avenir-Oblique
 Font: Avenir-HeavyOblique
 Font: Avenir-Heavy
 Font: Avenir-BlackOblique
 Font: Avenir-BookOblique
 Font: Avenir-Roman
 Font: Avenir-Medium
 Font: Avenir-Black
 Font: Avenir-Light
 Font: Avenir-MediumOblique
 Font: Avenir-Book
 Font: Avenir-LightOblique
 Font: DiwanMishafi
 Font: AcademyEngravedLetPlain
 Font: Futura-CondensedExtraBold
 Font: Futura-Medium
 Font: Futura-Bold
 Font: Futura-CondensedMedium
 Font: Futura-MediumItalic
 Font: PartyLetPlain
 Font: KannadaSangamMN-Bold
 Font: KannadaSangamMN
 Font: ArialHebrew-Bold
 Font: ArialHebrew-Light
 Font: ArialHebrew
 Font: Farah
 Font: Arial-BoldMT
 Font: Arial-BoldItalicMT
 Font: Arial-ItalicMT
 Font: ArialMT
 Font: Chalkduster
 Font: Kefa-Regular
 Font: HoeflerText-Italic
 Font: HoeflerText-Black
 Font: HoeflerText-Regular
 Font: HoeflerText-BlackItalic
 Font: Optima-ExtraBlack
 Font: Optima-BoldItalic
 Font: Optima-Italic
 Font: Optima-Regular
 Font: Optima-Bold
 Font: Palatino-Italic
 Font: Palatino-Roman
 Font: Palatino-BoldItalic
 Font: Palatino-Bold
 Font: MalayalamSangamMN-Bold
 Font: MalayalamSangamMN
 Font: AlNile
 Font: AlNile-Bold
 Font: LaoSangamMN
 Font: BradleyHandITCTT-Bold
 Font: HiraMinProN-W3
 Font: HiraMinProN-W6
 Font: PingFangHK-Medium
 Font: PingFangHK-Thin
 Font: PingFangHK-Regular
 Font: PingFangHK-Ultralight
 Font: PingFangHK-Semibold
 Font: PingFangHK-Light
 Font: Helvetica-Oblique
 Font: Helvetica-BoldOblique
 Font: Helvetica
 Font: Helvetica-Light
 Font: Helvetica-Bold
 Font: Helvetica-LightOblique
 Font: Courier-BoldOblique
 Font: Courier-Oblique
 Font: Courier
 Font: Courier-Bold
 Font: Cochin-Italic
 Font: Cochin-Bold
 Font: Cochin
 Font: Cochin-BoldItalic
 Font: TrebuchetMS-Bold
 Font: TrebuchetMS-Italic
 Font: Trebuchet-BoldItalic
 Font: TrebuchetMS
 Font: DevanagariSangamMN
 Font: DevanagariSangamMN-Bold
 Font: OriyaSangamMN
 Font: OriyaSangamMN-Bold
 Font: Rockwell-Italic
 Font: Rockwell-Regular
 Font: Rockwell-Bold
 Font: Rockwell-BoldItalic
 Font: SnellRoundhand
 Font: SnellRoundhand-Bold
 Font: SnellRoundhand-Black
 Font: ZapfDingbatsITC
 Font: BodoniSvtyTwoITCTT-Bold
 Font: BodoniSvtyTwoITCTT-BookIta
 Font: BodoniSvtyTwoITCTT-Book
 Font: Verdana-Italic
 Font: Verdana
 Font: Verdana-Bold
 Font: Verdana-BoldItalic
 Font: AmericanTypewriter-CondensedBold
 Font: AmericanTypewriter-Condensed
 Font: AmericanTypewriter-CondensedLight
 Font: AmericanTypewriter
 Font: AmericanTypewriter-Bold
 Font: AmericanTypewriter-Semibold
 Font: AmericanTypewriter-Light
 Font: AvenirNext-Medium
 Font: AvenirNext-DemiBoldItalic
 Font: AvenirNext-DemiBold
 Font: AvenirNext-HeavyItalic
 Font: AvenirNext-Regular
 Font: AvenirNext-Italic
 Font: AvenirNext-MediumItalic
 Font: AvenirNext-UltraLightItalic
 Font: AvenirNext-BoldItalic
 Font: AvenirNext-Heavy
 Font: AvenirNext-Bold
 Font: AvenirNext-UltraLight
 Font: Baskerville-SemiBoldItalic
 Font: Baskerville-SemiBold
 Font: Baskerville-BoldItalic
 Font: Baskerville
 Font: Baskerville-Bold
 Font: Baskerville-Italic
 Font: KhmerSangamMN
 Font: Didot-Bold
 Font: Didot
 Font: Didot-Italic
 Font: SavoyeLetPlain
 Font: BodoniOrnamentsITCTT
 Font: Symbol
 Font: Charter-BlackItalic
 Font: Charter-Bold
 Font: Charter-Roman
 Font: Charter-Black
 Font: Charter-BoldItalic
 Font: Charter-Italic
 Font: Menlo-BoldItalic
 Font: Menlo-Bold
 Font: Menlo-Italic
 Font: Menlo-Regular
 Font: NotoNastaliqUrdu
 Font: BodoniSvtyTwoSCITCTT-Book
 Font: DINAlternate-Bold
 Font: Papyrus-Condensed
 Font: Papyrus
 Font: HiraginoSans-W3
 Font: HiraginoSans-W6
 Font: PingFangSC-Medium
 Font: PingFangSC-Semibold
 Font: PingFangSC-Light
 Font: PingFangSC-Ultralight
 Font: PingFangSC-Regular
 Font: PingFangSC-Thin
 Font: MyanmarSangamMN
 Font: MyanmarSangamMN-Bold
 Font: Zapfino
 Font: BodoniSvtyTwoOSITCTT-BookIt
 Font: BodoniSvtyTwoOSITCTT-Book
 Font: BodoniSvtyTwoOSITCTT-Bold
 Font: EuphemiaUCAS
 Font: EuphemiaUCAS-Italic
 Font: EuphemiaUCAS-Bold
 Font: DINCondensed-Bold
 */
