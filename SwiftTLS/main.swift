//
//  main.swift
//  swifttls
//
//  Created by Nico Schmidt on 16.05.15.
//  Copyright (c) 2015 Nico Schmidt. All rights reserved.
//

import Foundation

func server()
{
    var serverIdentity = Identity(name: "Internet Widgits Pty Ltd")
    
    var port = 12345
    if Process.arguments.count >= 2 {
        let portString = Process.arguments[1]
        if let portNumber = Int(portString) {
            port = portNumber
        }
    }
    
    print("Listening on port \(port)")
    
    var server = TLSSocket(protocolVersion: .TLS_v1_0, isClient: false, identity: serverIdentity!)
    var address = IPv4Address.localAddress()
    address.port = UInt16(port)
    
    server.listen(address) {
        (clientSocket, error) -> () in
        
        if error != nil {
            print("Error: \(error)")
            exit(-1)
        }
        
        if clientSocket != nil {
            var recursiveBlock : ((data : [UInt8]?, error : SocketError?) -> ())!
            let readBlock = {
                (data : [UInt8]?, error : SocketError?) -> () in
                
                if var data = data {
                    print(NSString(bytesNoCopy: &data, length: data.count, encoding: NSUTF8StringEncoding, freeWhenDone: false)!)
                    clientSocket?.write(data, completionBlock: nil)
                }
                
                clientSocket?.read(count: 1024, completionBlock: recursiveBlock)
                
            }
            recursiveBlock = readBlock
            clientSocket?.read(count: 1024, completionBlock: readBlock)
        }
    }
}

func client()
{
    let socket = TLSSocket(protocolVersion: TLSProtocolVersion.TLS_v1_0)
    socket.context.cipherSuites = [.TLS_DHE_RSA_WITH_AES_256_CBC_SHA]
    
    //        var host = "195.50.155.66"
    let host = "85.13.145.53" // nschmidt.name
    //        let host = "127.0.0.1"
    //        let port = 4433
    let port = 443
    
    socket.connect(IPAddress.addressWithString(host, port: port)!, completionBlock: { (error : SocketError?) -> () in
        socket.write([UInt8]("GET / HTTP/1.1\r\nHost: nschmidt.name\r\n\r\n".utf8), completionBlock: { (error : SocketError?) -> () in
            socket.read(count: 4096, completionBlock: { (data, error) -> () in
                print("\(NSString(bytes: data!, length: data!.count, encoding: NSUTF8StringEncoding)!)")
                socket.close()
                
                print("Add operations: \(addOperations)")
                print("Sub operations: \(subOperations)")
                print("Mul operations: \(mulOperations)")
                print("Div operations: \(divOperations)")
                print("Mod operations: \(modOperations)")

            })
        })
        
        return
    })
}

func test_BN_multiply_performance()
{
            let generator = BigInt([2] as [UInt32], negative: false)
    let exponent = BigInt([3638070665, 4098930426, 774684981, 142589454, 462038241, 3758202187, 3492620728, 197316439, 3739259254, 3982239117, 478560844, 563167734, 2872575898, 262968980, 2216052839, 2459623197, 690887982, 2753184820, 2014754840, 4256897817, 642060222, 2444812560, 3161730652, 915677114, 735315038, 3184648832, 2032347441, 1467539025, 438508731, 4169815523, 3558080202, 2158440190, 2573709788, 656085636, 417408275, 354379138, 971458601, 378150612, 2943885095, 3600290736, 3021609794, 3225655909, 3341292748, 4226634663, 3122770336, 558400858, 4209805791, 911931225, 835168491, 2350378922, 2853412803, 2149277224, 44057360, 2015374949, 3433644351, 2125863198, 3002080040, 3804600865, 835739740, 1113425927, 247232497, 4289434401, 4050370225, 1660041635, 2139223242, 1306937116, 3263441734, 661376164, 3190400206, 488889274, 2734527078, 3352577645, 2470241059, 680352812, 2272601890, 49049853, 1251184103, 1788113003, 1710206605, 918106048, 3626953297, 1023883918, 1294899449, 4124715042, 696308608, 3871968895, 4080682574, 2457072110, 428337365, 3719082216, 1181860710, 688114283, 3734308685, 2156682057, 1117123056, 1936926947] as [UInt32], negative: false)
    let modulus = BigInt([3872228475, 3328948460, 3687141192, 52247963, 1203322039, 1733417249, 3530824422, 3785095757, 3570111076, 1960585351, 1809967537, 2746506138, 3538274879, 462835040, 3948696349, 1949280012, 195815007, 1497959045, 2501497860, 2659786217, 1895035012, 1732169943, 212876890, 2368821990, 1515135638, 3855497802, 2554994240, 2334113045, 2219838228, 1055249965, 196090165, 3207657238, 783240575, 3297946635, 3887033640, 3521069295, 539099221, 661174199, 1119237955, 433172843, 1423733793, 870499761, 4261686394, 1688468876, 2084226679, 3940295442, 3156067507, 2972495353, 680996583, 621170184, 2797291882, 1348955418, 3957266972, 2314072997, 2629322002, 4132121088, 3779026412, 3924904742, 705120737, 9413379, 1708149244, 2581455429, 3493074765, 1777752906, 1520683348, 1004423280, 604184962, 2640683990, 608051673, 2946192959, 3066651049, 882652335, 1553142157, 2767291429, 1818200329, 2393343544, 975190591, 422870306, 2903893790, 4184166305, 1790288688, 2665933195, 2795764371, 2766668581, 1882345281, 1944049535, 3031870379, 1276498010, 4088888483, 3277620424, 422136554, 1761109976, 3655251346, 2130671353, 3040501574, 2311252394] as [UInt32], negative: false)
    
    //        let generator = BigInt([2] as [UInt32], negative: false)
//            let exponent = BigInt([3116988641, 3983070910, 2701520770, 1363639321, 2557765447, 342272273, 2475071927, 2955743727, 2979479703, 715122230, 2343412841, 3499847595, 764462914, 263700299, 373275624, 1287566206] as [UInt32], negative: false)
//            let modulus = BigInt([1198843955, 3623894652, 503860470, 3793286365, 2731791378, 3614844779, 1771690793, 1464226003, 2319713261, 3985960860, 3087334159, 3712738611, 1867303570, 3504648053, 3649381001, 3663215638] as [UInt32], negative: false)
    
    let generatorString = generator.toString()
    let exponentString = exponent.toString()
    let modulusString = modulus.toString()
    
    var an = BN_new()
    BN_hex2bn(&an, generatorString)
    
    var bn = BN_new()
    BN_hex2bn(&bn, modulusString)

    var exp = BN_new()
    BN_hex2bn(&exp, exponentString)
    
    let context = BN_CTX_new()
    let result = BN_new()
    
    for var i=0; i < 1; ++i {
        BN_mod_exp(result, an, exp, bn, context)
    }
}

func testPerformance()
{
    let generator = BigInt([2] as [UInt32], negative: false)
    let exponent = BigInt([3638070665, 4098930426, 774684981, 142589454, 462038241, 3758202187, 3492620728, 197316439, 3739259254, 3982239117, 478560844, 563167734, 2872575898, 262968980, 2216052839, 2459623197, 690887982, 2753184820, 2014754840, 4256897817, 642060222, 2444812560, 3161730652, 915677114, 735315038, 3184648832, 2032347441, 1467539025, 438508731, 4169815523, 3558080202, 2158440190, 2573709788, 656085636, 417408275, 354379138, 971458601, 378150612, 2943885095, 3600290736, 3021609794, 3225655909, 3341292748, 4226634663, 3122770336, 558400858, 4209805791, 911931225, 835168491, 2350378922, 2853412803, 2149277224, 44057360, 2015374949, 3433644351, 2125863198, 3002080040, 3804600865, 835739740, 1113425927, 247232497, 4289434401, 4050370225, 1660041635, 2139223242, 1306937116, 3263441734, 661376164, 3190400206, 488889274, 2734527078, 3352577645, 2470241059, 680352812, 2272601890, 49049853, 1251184103, 1788113003, 1710206605, 918106048, 3626953297, 1023883918, 1294899449, 4124715042, 696308608, 3871968895, 4080682574, 2457072110, 428337365, 3719082216, 1181860710, 688114283, 3734308685, 2156682057, 1117123056, 1936926947] as [UInt32], negative: false)
    let modulus = BigInt([3872228475, 3328948460, 3687141192, 52247963, 1203322039, 1733417249, 3530824422, 3785095757, 3570111076, 1960585351, 1809967537, 2746506138, 3538274879, 462835040, 3948696349, 1949280012, 195815007, 1497959045, 2501497860, 2659786217, 1895035012, 1732169943, 212876890, 2368821990, 1515135638, 3855497802, 2554994240, 2334113045, 2219838228, 1055249965, 196090165, 3207657238, 783240575, 3297946635, 3887033640, 3521069295, 539099221, 661174199, 1119237955, 433172843, 1423733793, 870499761, 4261686394, 1688468876, 2084226679, 3940295442, 3156067507, 2972495353, 680996583, 621170184, 2797291882, 1348955418, 3957266972, 2314072997, 2629322002, 4132121088, 3779026412, 3924904742, 705120737, 9413379, 1708149244, 2581455429, 3493074765, 1777752906, 1520683348, 1004423280, 604184962, 2640683990, 608051673, 2946192959, 3066651049, 882652335, 1553142157, 2767291429, 1818200329, 2393343544, 975190591, 422870306, 2903893790, 4184166305, 1790288688, 2665933195, 2795764371, 2766668581, 1882345281, 1944049535, 3031870379, 1276498010, 4088888483, 3277620424, 422136554, 1761109976, 3655251346, 2130671353, 3040501574, 2311252394] as [UInt32], negative: false)
    
//    let generator = BigInt([2] as [UInt32], negative: false)
//    let exponent = BigInt([3116988641, 3983070910, 2701520770, 1363639321, 2557765447, 342272273, 2475071927, 2955743727, 2979479703, 715122230, 2343412841, 3499847595, 764462914, 263700299, 373275624, 1287566206] as [UInt32], negative: false)
//    let modulus = BigInt([1198843955, 3623894652, 503860470, 3793286365, 2731791378, 3614844779, 1771690793, 1464226003, 2319713261, 3985960860, 3087334159, 3712738611, 1867303570, 3504648053, 3649381001, 3663215638] as [UInt32], negative: false)

    for var i = 0; i < 1; ++i {
        modular_pow(generator, exponent, modulus)
//    exponent * modulus
    }
}

//client()
testPerformance()

//test_BN_multiply_performance()

print("Add operations: \(addOperations)")
print("Sub operations: \(subOperations)")
print("Mul operations: \(mulOperations)")
print("Div operations: \(divOperations)")
print("Mod operations: \(modOperations)")
//dispatch_main()