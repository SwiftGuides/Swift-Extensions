//
//  AVAudioSession+Extension.swift
//
//  Created by Augus on 4/9/16.
//  Copyright © 2016 iAugus. All rights reserved.
//

import AVFoundation


extension AVAudioSession {
    
    func setCategory(backgroundAndMix backgroundAndMix: Bool) {
        if backgroundAndMix {
            _ = try? setCategory(AVAudioSessionCategoryPlayAndRecord, withOptions: .MixWithOthers)
        } else {
            _ = try? setCategory(AVAudioSessionCategoryPlayAndRecord)
        }
    }

}


