//
//  OnboardingData.swift
//  Amoogye
//
//  Created by JunHui Kim on 07/09/2019.
//  Copyright © 2019 KookKook. All rights reserved.
//

import Foundation
import Lottie

enum ContentType {
    case lottie
    case video
}

class OnboardingData {
    let title: String
    let description: String
    let type: ContentType
    let filename: String
    var endFrame: CGFloat?
    var repeatFrame: CGFloat?
    var backgroundColor: UIColor?

    init(title: String, description: String, type: ContentType, filename: String) {
        self.title = title
        self.description = description
        self.type = type
        self.filename = filename
    }

    init(title: String, description: String, type: ContentType, filename: String, endFrame: CGFloat, repeatFrame: CGFloat, backgroundColor: UIColor) {
        self.title = title
        self.description = description
        self.type = type
        self.filename = filename
        self.endFrame = endFrame
        self.repeatFrame = repeatFrame
        self.backgroundColor = backgroundColor
    }
}

extension OnboardingData {
    static func contents() -> [OnboardingData] {
        var contents = [OnboardingData]()

        contents.append(OnboardingData(
            title: "소금 20g, 눈대중으로 넣으세요?",
            description: """
                        계량컵과 계량스푼 없이 식재료 양을
                        측정하는 것은 어려운 일이죠.
                        """,
            type: .lottie,
            filename: "onboardingPage1",
            endFrame: 180,
            repeatFrame: 114,
            backgroundColor: UIColor(displayP3Red: 241/255.0, green: 246/255.0, blue: 255/255.0, alpha: 1.0)
        ))
        contents.append(OnboardingData(
            title: "이제 쉽게 계량할 수 있습니다",
            description: """
                        아무계를 이용하면 종이컵, 밥숟가락 등
                        우리 주변의 도구로 측정할 수 있으니까요.
                        """,
            type: .lottie,
            filename: "onboardingPage2",
            endFrame: 148,
            repeatFrame: 76,
            backgroundColor: UIColor(displayP3Red: 238/255.0, green: 253/255.0, blue: 250/255.0, alpha: 1.0)
        ))
        contents.append(OnboardingData(
            title: "어떻게 계량하냐구요?",
            description: """
                        60ml를 밥숟가락으로 계량해보겠습니다.
                        """,
            type: .video,
            filename: "onboardingPage3"
        ))
        contents.append(OnboardingData(
            title: "레시피가 만약 3인분 기준이었다면",
            description: """
                        2인분으로도 바꿀 수 있습니다.
                        """,
            type: .video,
            filename: "onboardingPage4"
        ))
        contents.append(OnboardingData(
            title: "이제 아무계와 함께 쉽게 요리해요",
            description: """
                        지금부터 주변의 아무거나로
                        계량을 시작해보세요!
                        """,
            type: .lottie,
            filename: "onboardingPage5",
            endFrame: 128,
            repeatFrame: 0,
            backgroundColor: UIColor(displayP3Red: 239/255.0, green: 251/255.0, blue: 255/255.0, alpha: 1.0)
        ))

        return contents
    }
}
