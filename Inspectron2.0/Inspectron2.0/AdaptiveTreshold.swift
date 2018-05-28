//
//  AdaptiveTreshold.swift
//  Inspectron2.0
//
//  Created by Caliendo Domenico on 25/05/18.
//  Copyright © 2018 Caliendo Domenico. All rights reserved.
//

import Vision
import CoreImage
import AVKit
import UIKit
class AdaptiveTreshold: CIFilter{

    var inputImage : CIImage?
    
    
    //    var thresholdKernel =  CIColorKernel(source:
    //        "kernel vec4 thresholdFilter(__sample image, __sample threshold)" +
    //            "{" +
    //            "   float imageLuma = dot(image.rgb, vec3(0.2126, 0.7152, 0.0722));" +
    //            "   float thresholdLuma = dot(threshold.rgb, vec3(0.2126, 0.7152, 0.0722));" +
    //
    //            "   return vec4(vec3(step(imageLuma, thresholdLuma)), 1.0);" +
    //        "}"
    //    )
    //
    //
    //    override var outputImage: CIImage!
    //    {
    //        guard let inputImage = inputImage,
    //            let thresholdKernel = thresholdKernel else
    //        {
    //            return nil
    //        }
    //
    //        let blurred = inputImage.applyingFilter("CIBoxBlur",
    //                                                parameters: [kCIInputRadiusKey: 9])
    //
    //        let extent = inputImage.extent
    //        let arguments = [inputImage, blurred]
    //
    //        return thresholdKernel.apply(extent: extent, arguments: arguments)
    //    }
    
    
     var threshold: Float = 0.384688 //This is set to a good value via Otsu's method

    
    var thresholdKernel =  CIColorKernel(source:
        "kernel vec4 thresholdKernel(sampler image, float threshold) {" +
            "  vec4 pixel = sample(image, samplerCoord(image));" +
            "  const vec3 rgbToIntensity = vec3(0.114, 0.587, 0.299);" +
            "  float intensity = dot(pixel.rgb, rgbToIntensity);" +
            "  return intensity < threshold ? vec4(0, 0, 0, 1) : vec4(1, 1, 1, 1);" +
        "}")
    
    override var outputImage: CIImage! {
        guard let inputImage = inputImage,
            let thresholdKernel = thresholdKernel else {
                return nil
        }
        
        let extent = inputImage.extent
        let arguments : [Any] = [inputImage, threshold]
        return thresholdKernel.apply(extent: extent, arguments: arguments)
    }
    

}
