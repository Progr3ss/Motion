//
//  AVAssetImageGeneratorTimePoints.swift
//  Gif Motion
//
//  Created by martin chibwe on 6/16/17.
//  Copyright © 2017 Martin Chibwe. All rights reserved.
//

import AVFoundation

public extension AVAssetImageGenerator {
	public func generateCGImagesAsynchronouslyForTimePoints(_ timePoints: [TimePoint], completionHandler: @escaping AVAssetImageGeneratorCompletionHandler) {
		let times = timePoints.map {timePoint in
			return NSValue(time: timePoint)
		}
		self.generateCGImagesAsynchronously(forTimes: times, completionHandler: completionHandler)
	}
}

