using Test, Aqua, LibAwsMqtt, LibAwsCommon

@testset "LibAwsMqtt" begin
    @testset "aqua" begin
        Aqua.test_all(LibAwsMqtt, ambiguities=false)
        Aqua.test_ambiguities(LibAwsMqtt)
    end
    @testset "basic usage to test the library loads" begin
        alloc = aws_default_allocator() # important! this shouldn't need to be qualified! if we generate a definition for it in LibAwsMqtt that is a bug.
        aws_mqtt_library_init(alloc)
    end
end
