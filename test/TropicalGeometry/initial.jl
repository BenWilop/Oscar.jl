@testset "initial" begin
    Kx,(x0,x1,x2,x3,x4,x5) = PolynomialRing(QQ,6)
    Cyclic5Homogenized = ideal([x1+x2+x3+x4+x5,
                                   x1*x2+x2*x3+x3*x4+x1*x5+x4*x5,
                                   x1*x2*x3+x2*x3*x4+x1*x2*x5+x1*x4*x5+x3*x4*x5,
                                   x1*x2*x3*x4+x1*x2*x3*x5+x1*x2*x4*x5+x1*x3*x4*x5+x2*x3*x4*x5,
                                   -x0^5+x1*x2*x3*x4*x5])
    Katsura5Homogenized = ideal([-x0+x1+2*x2+2*x3+2*x4+2*x5,
                                    -x0*x1+x1^2+2*x2^2+2*x3^2+2*x4^2+2*x5^2,
                                    -x0*x2+2*x1*x2+2*x2*x3+2*x3*x4+2*x4*x5,
                                    x2^2-x0*x3+2*x1*x3+2*x2*x4+2*x3*x5,
                                    2*x2*x3-x0*x4+2*x1*x4+2*x2*x5])
    w = [0,0,0,0,0,0]
    @testset "val_2" begin
        val_2 = ValuationMap(QQ,2)
        @testset "Cyclic5Homogenized" begin
            computed = gens(initial(Cyclic5Homogenized, val_2, w))
            # Apparently the Groebner basis lives in a different ring, so we have
            # to hack around this...
            computed_ring = parent(computed[1])
            (y1, y2, y3, y4, y5, y6) = gens(computed_ring)
            expected = [y2 + y3 + y4 + y5 + y6, y3^2 + y3*y5 + y4*y5 + y4*y6 + y6^2, y3*y4^2 + y3*y4*y5 + y3*y5*y6 + y3*y6^2 + y4^2*y5 + y4^2*y6 + y4*y5*y6 + y5^2*y6 + y5*y6^2 + y6^3, y3*y4*y5^2 + y3*y4*y5*y6 + y3*y4*y6^2 + y3*y5^2*y6 + y3*y5*y6^2 + y3*y6^3 + y4^2*y5*y6 + y4*y5^2*y6 + y4*y6^3 + y5^3*y6 + y5*y6^3 + y6^4, y3*y4*y5^2 + y3*y5*y6^2 + y4^3*y5 + y4^3*y6 + y4^2*y5^2 + y4*y5^2*y6 + y4*y6^3 + y5^2*y6^2, y3*y4*y5*y6^2 + y3*y5^3*y6 + y4^3*y6^2 + y4^2*y5^2*y6 + y4^2*y5*y6^2 + y4^2*y6^3 + y4*y5^3*y6 + y4*y5*y6^3 + y5^4*y6 + y5^3*y6^2, y3*y4*y6^3 + y3*y5^3*y6 + y3*y5^2*y6^2 + y3*y6^4 + y4^2*y5^3 + y4^2*y5*y6^2 + y4^2*y6^3 + y5^4*y6 + y5^3*y6^2 + y5^2*y6^3 + y5*y6^4 + y6^5, y1^5 + y3*y4*y6^3 + y3*y6^4 + y4^2*y5*y6^2 + y4*y5*y6^3 + y4*y6^4 + y5^2*y6^3 + y6^5, y3*y4*y6^4 + y3*y5^3*y6^2 + y3*y5^2*y6^3 + y3*y6^5 + y4^4*y6^2 + y4^3*y6^3 + y4^2*y5*y6^3 + y4*y6^5 + y5^2*y6^4 + y6^6, y3*y4*y6^4 + y3*y5^3*y6^2 + y3*y5^2*y6^3 + y3*y6^5 + y4^4*y6^2 + y4^2*y6^4 + y4*y5^4*y6 + y4*y5^3*y6^2 + y4*y6^5 + y5^4*y6^2 + y5^2*y6^4 + y6^6, y3*y4*y6^4 + y3*y5^4*y6 + y3*y5^3*y6^2 + y3*y5^2*y6^3 + y3*y5*y6^4 + y3*y6^5 + y4^3*y6^3 + y4^2*y6^4 + y4*y5^4*y6 + y4*y6^5 + y5^5*y6 + y5^3*y6^3 + y5*y6^5 + y6^6, y3*y4*y5*y6^4 + y3*y5^3*y6^3 + y4^2*y5*y6^4 + y4*y5^2*y6^4 + y4*y5*y6^5 + y5^5*y6^2 + y5^4*y6^3 + y5^3*y6^4]
            @test computed == expected
        end
        @testset "Katsura5Homogenized" begin
            computed = gens(initial(Katsura5Homogenized, val_2, w))
            # Apparently the Groebner basis lives in a different ring, so we have
            # to hack around this...
            computed_ring = parent(computed[1])
            (y1, y2, y3, y4, y5, y6) = gens(computed_ring)
            expected = [y1 + y2, y2*y6 + y4^2 + y5^2 + y6^2, y2*y5, y2*y4 + y2*y5 + y3^2, y2*y3, y2*y5^2, y2*y4*y5 + y2*y5*y6, y2^2*y5, y2^2*y4 + y2*y5^2, y2^3*y6 + y2^2*y6^2, y2*y5^2*y6, y2^2*y6^2 + y2*y4*y6^2 + y2*y5^2*y6 + y2*y5*y6^2 + y2*y6^3 + y3*y5^3 + y3*y5*y6^2 + y4*y5^2*y6 + y5^4 + y5^2*y6^2, y2*y5^3 + y2*y5^2*y6, y2^4*y6 + y2^3*y6^2 + y2*y5^2*y6^2, y2*y5^2*y6^2]
            @test computed == expected
        end
    end

    @testset "val_3" begin
        val_3 = ValuationMap(QQ,3)
        @testset "Cyclic5Homogenized" begin
            computed = gens(initial(Cyclic5Homogenized, val_3, w))
            # Apparently the Groebner basis lives in a different ring, so we have
            # to hack around this...
            computed_ring = parent(computed[1])
            (y1, y2, y3, y4, y5, y6) = gens(computed_ring)
            expected = [y2 + y3 + y4 + y5 + y6, y3^2 + y3*y5 + 2*y3*y6 + 2*y4*y5 + y4*y6 + y6^2, y3*y4^2 + 2*y3*y4*y5 + y3*y5*y6 + 2*y3*y6^2 + y4^2*y5 + 2*y4^2*y6 + y4*y5*y6 + y4*y6^2 + y5^2*y6 + y5*y6^2 + 2*y6^3, y3*y4*y5^2 + y3*y4*y5*y6 + 2*y3*y4*y6^2 + 2*y3*y5^2*y6 + 2*y3*y5*y6^2 + y3*y6^3 + y4^2*y5*y6 + y4*y5^2*y6 + y4*y6^3 + 2*y5^3*y6 + y5^2*y6^2 + 2*y5*y6^3 + y6^4, y3*y4*y5^2 + y3*y4*y6^2 + y3*y6^3 + y4^3*y5 + 2*y4^3*y6 + 2*y4^2*y5^2 + y4^2*y5*y6 + 2*y4^2*y6^2 + y4*y5^2*y6 + 2*y4*y5*y6^2 + y4*y6^3 + 2*y5*y6^3 + y6^4, 2*y3*y4*y5*y6^2 + y3*y4*y6^3 + 2*y3*y5^3*y6 + y3*y5^2*y6^2 + y3*y5*y6^3 + 2*y3*y6^4 + y4^3*y6^2 + y4^2*y5^2*y6 + 2*y4^2*y5*y6^2 + 2*y4^2*y6^3 + y4*y5^2*y6^2 + 2*y5^4*y6 + y5^3*y6^2 + 2*y6^5, y3*y4*y5*y6^2 + 2*y3*y5^3*y6 + 2*y3*y5^2*y6^2 + 2*y3*y5*y6^3 + 2*y3*y6^4 + y4^2*y5^3 + 2*y4^2*y5*y6^2 + y4^2*y6^3 + y4*y5^2*y6^2 + y4*y5*y6^3 + 2*y5^4*y6 + 2*y5^2*y6^3 + 2*y6^5, y1^5 + y3*y4*y5*y6^2 + y3*y4*y6^3 + 2*y3*y5*y6^3 + 2*y3*y6^4 + 2*y4^2*y5*y6^2 + y4*y5^2*y6^2 + y4*y5*y6^3 + 2*y4*y6^4 + y5^2*y6^3 + 2*y5*y6^4 + 2*y6^5, 2*y3*y4*y5*y6^3 + y3*y6^5 + y4^4*y6^2 + 2*y4^2*y6^4 + 2*y4*y5^3*y6^2 + 2*y4*y5^2*y6^3 + 2*y4*y5*y6^4 + y4*y6^5 + 2*y5^4*y6^2 + 2*y5^3*y6^3 + 2*y5^2*y6^4 + y5*y6^5 + y6^6, y3*y4*y5*y6^3 + 2*y3*y4*y6^4 + y3*y5^3*y6^2 + y3*y5^2*y6^3 + y3*y5*y6^4 + 2*y4^4*y6^2 + y4^3*y6^3 + 2*y4^2*y5*y6^3 + y4*y5^4*y6 + y4*y5^3*y6^2 + y4*y5^2*y6^3 + y4*y6^5 + y5^4*y6^2 + y5^3*y6^3 + 2*y5^2*y6^4 + 2*y5*y6^5, y3*y4*y5*y6^3 + y3*y5^4*y6 + y3*y5^3*y6^2 + 2*y3*y5*y6^4 + y3*y6^5 + 2*y4^3*y6^3 + 2*y4^2*y5*y6^3 + 2*y4*y5^3*y6^2 + 2*y4*y6^5 + y5^5*y6 + y5^4*y6^2 + 2*y5^3*y6^3 + 2*y5*y6^5 + y6^6, y3*y4*y5*y6^4 + 2*y3*y5^3*y6^3 + y3*y5^2*y6^4 + y3*y5*y6^5 + y3*y6^6 + 2*y4^2*y5*y6^4 + 2*y4^2*y6^5 + y4*y5^3*y6^3 + y4*y5*y6^5 + y5^5*y6^2 + y5^3*y6^4 + y6^7]
            @test computed == expected
        end
        @testset "Katsura5Homogenized" begin
            computed = gens(initial(Katsura5Homogenized, val_3, w))
            # Apparently the Groebner basis lives in a different ring, so we have
            # to hack around this...
            computed_ring = parent(computed[1])
            (y1, y2, y3, y4, y5, y6) = gens(computed_ring)
            expected = [y1 + 2*y2 + y3 + y4 + y5 + y6, y2*y6 + 2*y3*y5 + y4^2 + 2*y4*y5 + y5^2 + 2*y6^2, y2*y5 + 2*y3*y4 + y3*y5 + 2*y3*y6 + y4*y5 + y5^2 + y5*y6, y2*y4 + y2*y5 + y3^2 + 2*y3*y6 + y4^2 + 2*y4*y5 + y5^2 + y5*y6, y2*y3 + 2*y2*y4 + 2*y2*y5 + y3*y5 + 2*y3*y6 + 2*y4^2 + 2*y5^2 + y5*y6, y2^2*y6 + y2*y5^2 + y2*y5*y6 + y3*y5^2 + y3*y5*y6 + 2*y4*y5^2 + 2*y4*y6^2 + y5^3 + 2*y5^2*y6 + 2*y5*y6^2 + 2*y6^3, y2^2*y6 + y2*y4*y5 + 2*y2*y4*y6 + y2*y6^2 + y3*y5^2 + 2*y3*y6^2 + 2*y4*y5*y6 + 2*y4*y6^2 + 2*y5^3 + 2*y5^2*y6 + 2*y5*y6^2 + y6^3, y2^2*y5 + y2^2*y6 + 2*y2*y4*y6 + y2*y5^2 + 2*y2*y5*y6 + y2*y6^2 + 2*y3*y5^2 + y3*y5*y6 + 2*y3*y6^2 + y4*y5*y6 + 2*y4*y6^2 + 2*y5^3 + 2*y5^2*y6 + 2*y5*y6^2 + y6^3, y2^2*y4 + 2*y2^2*y6 + 2*y2*y4*y6 + 2*y2*y6^2 + 2*y3*y5^2 + y3*y5*y6 + 2*y3*y6^2 + y4*y5^2 + 2*y4*y5*y6 + y5^3 + y5^2*y6 + 2*y5*y6^2 + 2*y6^3, 2*y2^3*y6 + y2^2*y6^2 + 2*y2*y4*y6^2 + 2*y2*y5^2*y6 + 2*y2*y5*y6^2 + 2*y3*y5^2*y6 + y3*y6^3 + 2*y4*y6^3 + 2*y5^3*y6 + y5^2*y6^2 + 2*y5*y6^3, 2*y2^2*y6^2 + 2*y2*y4*y6^2 + y2*y5^2*y6 + y2*y6^3 + 2*y3*y5*y6^2 + 2*y3*y6^3 + 2*y4*y5^3 + y4*y5^2*y6 + 2*y4*y5*y6^2 + y4*y6^3 + 2*y5^2*y6^2 + 2*y5*y6^3, y2^2*y6^2 + 2*y2*y4*y6^2 + y2*y5^2*y6 + 2*y2*y5*y6^2 + y2*y6^3 + y3*y5^3 + y3*y5^2*y6 + 2*y3*y6^3 + 2*y4*y6^3 + 2*y5^4 + 2*y5^3*y6 + y5^2*y6^2 + y6^4, 2*y2^2*y6^2 + y2*y4*y6^2 + y2*y5^3 + y2*y5*y6^2 + 2*y2*y6^3 + y3*y5^3 + 2*y3*y5^2*y6 + 2*y3*y5*y6^2 + y3*y6^3 + 2*y4*y5^3 + y4*y5*y6^2 + y4*y6^3 + y5^4 + 2*y6^4, y2^4*y6 + y2^3*y6^2 + 2*y2*y4*y6^3 + y2*y5^2*y6^2 + 2*y2*y5*y6^3 + 2*y3*y5*y6^3 + 2*y4*y5^2*y6^2 + y4*y6^4 + 2*y5^4*y6 + y5^3*y6^2 + y5*y6^4 + y6^5, 2*y2*y4*y6^3 + y2*y6^4 + 2*y3*y5^2*y6^2 + 2*y3*y5*y6^3 + 2*y3*y6^4 + y4*y5*y6^3 + 2*y5^4*y6 + 2*y5^2*y6^3 + 2*y5*y6^4 + 2*y6^5]
            @test computed == expected
        end
    end
    @testset "val_t" begin
        Kt,t = RationalFunctionField(QQ,"t")
        Ktx,(x0,x1,x2,x3,x4,x5) = PolynomialRing(Kt,6)
        Cyclic5Homogenized_Kt = ideal([change_coefficient_ring(Kt,f) for f in gens(Cyclic5Homogenized)])
        Katsura5Homogenized_Kt = ideal([change_coefficient_ring(Kt,f) for f in gens(Katsura5Homogenized)])
        val_t = ValuationMap(Kt,t)
        @testset "Cyclic5Homogenized_Kt" begin
            computed = gens(initial(Cyclic5Homogenized_Kt, val_t, w))
            # Apparently the Groebner basis lives in a different ring, so we have
            # to hack around this...
            computed_ring = parent(computed[1])
            (y1, y2, y3, y4, y5, y6) = gens(computed_ring)
            expected = [y2 + y3 + y4 + y5 + y6, y2*y6 - y3^2 - y3*y5 - y3*y6 + y4*y5 + y5*y6, -y2*y3*y6 + y2*y4*y6 - y2*y5*y6 + y3*y4^2 - y3*y4*y5 + y4^2*y5, -y2*y3*y4*y6 - y2*y4*y5*y6 + y2*y5^2*y6 + y3*y4*y5^2 - y3*y4*y5*y6 + y4*y5^2*y6, -y2*y3^2*y6 + y2*y3*y4*y6 - y2*y3*y5*y6 + y2*y4^2*y6 - y2*y4*y5*y6 - y3*y4^2*y6 + y3*y4*y5^2 + y3*y4*y5*y6 + y4^3*y5 - y4^2*y5^2 + y4^2*y5*y6 - y4*y5^2*y6, 2*y2*y3^2*y6^2 - 2*y2*y3*y4*y6^2 + 4*y2*y3*y5*y6^2 - y2*y4^2*y6^2 - y2*y4*y5*y6^2 + y2*y5^3*y6 + 2*y2*y5^2*y6^2 + y3*y4^2*y6^2 - 2*y3*y4*y5*y6^2 + y4^2*y5^2*y6 + y4^2*y5*y6^2 - 2*y4*y5^3*y6 + 3*y4*y5^2*y6^2 - 2*y5^3*y6^2, y2*y3^2*y4*y6 + 2*y2*y3*y4*y5*y6 - y2*y3*y5^2*y6 - y2*y5^3*y6 + y3^2*y4*y5*y6 + y3*y4*y5^2*y6 - y4^2*y5^3 - 2*y4*y5^3*y6, -y1^5 + y2*y3*y4*y5*y6, -3*y2*y3^2*y5*y6^2 + 2*y2*y3^2*y6^3 + 2*y2*y3*y4*y5*y6^2 + 2*y2*y3*y4*y6^3 - y2*y3*y5^2*y6^2 - 2*y2*y4^2*y5*y6^2 - 6*y2*y4^2*y6^3 + 4*y2*y4*y5^2*y6^2 + 3*y2*y4*y5*y6^3 + y2*y5^3*y6^2 + y3^2*y4*y5*y6^2 - 2*y3^2*y4*y6^3 + 2*y3^2*y5*y6^3 + 4*y3*y4^2*y5*y6^2 + 4*y3*y4^2*y6^3 - 5*y3*y4*y5^2*y6^2 - y3*y4*y5*y6^3 + 2*y3*y5^3*y6^2 + y4^4*y6^2 - 4*y4^3*y5*y6^2 + y4^3*y6^3 + 2*y4^2*y5^2*y6^2 - 3*y4^2*y5*y6^3 + y5^4*y6^2, y2*y3^2*y5*y6^2 - 2*y2*y3*y4^2*y6^2 - 3*y2*y3*y4*y5*y6^2 + 3*y2*y3*y5^2*y6^2 - y2*y4^3*y6^2 - 2*y2*y4^2*y5*y6^2 + y2*y4*y5^2*y6^2 + 4*y2*y5^3*y6^2 - 2*y3^2*y4*y5*y6^2 + y3*y4^3*y6^2 - y3*y4^2*y5*y6^2 - 5*y3*y4*y5^2*y6^2 + y4^3*y5*y6^2 + 2*y4^2*y5^2*y6^2 - y4*y5^4*y6 + 4*y4*y5^3*y6^2, -y2*y3^2*y4*y6^2 - 2*y2*y3^2*y5*y6^2 - 3*y2*y3*y5^2*y6^2 + y2*y4^2*y5*y6^2 + y2*y4*y5^2*y6^2 - y2*y5^3*y6^2 - y3^2*y4*y5*y6^2 - y3*y4^2*y5*y6^2 + y3*y4*y5^2*y6^2 + y3*y5^4*y6 - y4^2*y5^2*y6^2 + 3*y4*y5^4*y6 - y4*y5^3*y6^2 + y5^5*y6 + 3*y5^4*y6^2, -4*y2*y3^2*y5*y6^3 + 13*y2*y3*y4^2*y6^3 + 16*y2*y3*y4*y5*y6^3 - 11*y2*y3*y5^2*y6^3 + 6*y2*y4^3*y6^3 + 9*y2*y4^2*y5*y6^3 - 12*y2*y4*y5^2*y6^3 - 16*y2*y5^3*y6^3 + 11*y3^2*y4*y5*y6^3 + 2*y3^2*y5^2*y6^3 - 6*y3*y4^3*y6^3 + 10*y3*y4^2*y5*y6^3 + 23*y3*y4*y5^2*y6^3 + 3*y3*y5^3*y6^3 - 7*y4^3*y5*y6^3 - 12*y4^2*y5^2*y6^3 - 21*y4*y5^3*y6^3 - y5^5*y6^2 - 3*y5^4*y6^3]
            @test computed == expected
        end
        @testset "Katsura5Homogenized_Kt" begin
            computed = gens(initial(Katsura5Homogenized_Kt, val_t, w))
            # Apparently the Groebner basis lives in a different ring, so we have
            # to hack around this...
            computed_ring = parent(computed[1])
            (y1, y2, y3, y4, y5, y6) = gens(computed_ring)
            expected = [-y1 + y2 + 2*y3 + 2*y4 + 2*y5 + 2*y6, 4*y1*y5 - 4*y2*y5 + 4*y2*y6 + 4*y4^2 - 4*y5^2 - 8*y5*y6 - 4*y6^2, -y1*y5 + 2*y2*y5 + 2*y3*y4 + 2*y3*y6, -y1*y4 + 2*y2*y4 + y3^2 + 2*y3*y5 + 2*y4*y6, -y2*y3 + 2*y3^2 + 2*y3*y5 + 2*y3*y6 - 2*y4*y5 - 2*y5*y6, 20480*y2^2*y6 - 24576*y2*y3*y6 - 40960*y2*y4*y6 + 75776*y2*y5^2 - 40960*y2*y5*y6 - 20480*y2*y6^2 + 20480*y3^2*y6 - 16384*y3*y4*y6 - 200704*y3*y5^2 + 192512*y3*y5*y6 + 24576*y3*y6^2 - 253952*y4*y5^2 + 16384*y4*y5*y6 + 40960*y4*y6^2 - 151552*y5^3 - 212992*y5^2*y6 + 40960*y5*y6^2, 8*y2*y3*y6 - 20*y2*y4*y5 + 56*y3*y4*y5 - 8*y3*y4*y6 - 24*y3*y5^2 - 8*y3*y6^2 + 40*y4^2*y5 + 40*y4*y5^2 + 8*y4*y5*y6, -4*y1*y3*y5 - 2*y2^2*y5 + 12*y2*y3*y5 - 4*y2*y3*y6 + 4*y2*y4*y5 + 4*y2*y5^2 + 4*y2*y5*y6 + 8*y3^2*y6 - 8*y3*y4*y5 - 8*y3*y4*y6 + 8*y4^2*y5 + 8*y4*y5*y6, -2*y1*y3*y4 - y2^2*y4 + 6*y2*y3*y4 - 2*y2*y3*y5 + 2*y2*y4^2 + 2*y2*y4*y5 + 2*y3^2*y5 - 2*y3^2*y6 + 2*y3*y4*y5 + 4*y3*y4*y6 + 2*y3*y5*y6, 31045614205309944077363603764769733957638250561536000000*y2^3*y6 - 92962339930054303675702972949182749612549896929280000000*y2^2*y3*y6 - 55112390086041477015987403457900478971666782580899840000*y2^2*y4*y6 - 149476335589048026056597493995138893139467192904974336000*y2^2*y5*y6 - 31045614205309944077363603764769733957638250561536000000*y2^2*y6^2 + 97894737665728789016803581882520616593699046068060160000*y2*y3^2*y6 + 78204108413622692937354648965135563828325729811038208000*y2*y3*y4*y6 + 232734295607714572210298687381820334722156010764500992000*y2*y3*y5*y6 + 92962339930054303675702972949182749612549896929280000000*y2*y3*y6^2 - 13957676649156822277479608143277977887219437084344320000*y2*y4^2*y6 + 185649029071947408788151847799736659727272546928689152000*y2*y4*y5*y6 + 55112390086041477015987403457900478971666782580899840000*y2*y4*y6^2 - 32491384821669232305996516075810129703148378105315328000*y2*y5^2*y6 + 149476335589048026056597493995138893139467192904974336000*y2*y5*y6^2 - 55707602883682370782866648431459068863383996255436800000*y3^3*y6 + 51544920631524307765033122816806244034316915546521600000*y3^2*y4*y6 - 151561484046455250915835446002722609966954148272275456000*y3^2*y5*y6 - 66849123460418844939439978117750882636060795506524160000*y3^2*y6^2 - 5583070659662728910991843257311191154887774833737728000*y3*y4^2*y6 - 322897739367369670953218106248516700225552084585414656000*y3*y4*y5*y6 - 103040599777870648199245531976951350994436330260267008000*y3*y4*y6^2 - 156666353891296895026485925707716366854892997492867072000*y3*y5^2*y6 - 170643067197094684055571479852280866806879509641428992000*y3*y5*y6^2 + 5583070659662728910991843257311191154887774833737728000*y4^2*y5*y6 + 13957676649156822277479608143277977887219437084344320000*y4^2*y6^2 + 271352818735845363188184983431710456191235169038893056000*y4*y5^2*y6 - 160812537707699453526260964787920872561161946479460352000*y4*y5*y6^2 - 114124756562595675877646277712699778278615009984512000000*y5^4 + 363935440821434516725188020141898045685231142020579328000*y5^3*y6 - 60645457794260599926094295218499072169766373579292672000*y5^2*y6^2, -1256366233686191714074624000*y2^2*y3*y6 + 1242476757735892107185356800*y2^2*y4*y6 + 1873311501805863343719710720*y2^2*y5*y6 + 1507639480423430056889548800*y2*y3^2*y6 + 1021760358089312899526819840*y2*y3*y4*y6 + 897512682315723688808284160*y2*y3*y5*y6 + 1256366233686191714074624000*y2*y3*y6^2 - 2484953515471784214370713600*y2*y4^2*y6 - 6231576519083510901810135040*y2*y4*y5*y6 - 1242476757735892107185356800*y2*y4*y6^2 + 2465760785067733848487362560*y2*y5^2*y6 - 1873311501805863343719710720*y2*y5*y6^2 - 1256366233686191714074624000*y3^3*y6 + 2247569744684845478445056000*y3^2*y4*y6 - 9936531094844338768581754880*y3^2*y5*y6 - 1507639480423430056889548800*y3^2*y6^2 - 993981406188713685748285440*y3*y4^2*y6 + 8542785317213365488184197120*y3*y4*y5*y6 - 1021760358089312899526819840*y3*y4*y6^2 + 7515721704670301829663293440*y3*y5^2*y6 - 897512682315723688808284160*y3*y5*y6^2 + 993981406188713685748285440*y4^2*y5*y6 + 2484953515471784214370713600*y4^2*y6^2 + 12355320197607423037407232000*y4*y5^3 - 10790355061898210966629253120*y4*y5^2*y6 + 6231576519083510901810135040*y4*y5*y6^2 + 6212383788679460535926784000*y5^4 + 3677175623860228652993085440*y5^3*y6 - 2465760785067733848487362560*y5^2*y6^2, 248302796800*y2^2*y4*y6 + 18790481920*y2^2*y5*y6 - 297963356160*y2*y3*y4*y6 + 344939560960*y2*y3*y5*y6 - 496605593600*y2*y4^2*y6 - 534186557440*y2*y4*y5*y6 - 248302796800*y2*y4*y6^2 + 1203933020160*y2*y5^2*y6 - 18790481920*y2*y5*y6^2 + 248302796800*y3^2*y4*y6 + 18790481920*y3^2*y5*y6 - 198642237440*y3*y4^2*y6 + 1951525765120*y3*y4*y5*y6 + 297963356160*y3*y4*y6^2 + 1335466393600*y3*y5^3 + 37580963840*y3*y5^2*y6 - 344939560960*y3*y5*y6^2 + 198642237440*y4^2*y5*y6 + 496605593600*y4^2*y6^2 + 2389075558400*y4*y5^3 - 2199828561920*y4*y5^2*y6 + 534186557440*y4*y5*y6^2 + 1241513984000*y5^4 - 56371445760*y5^3*y6 - 1203933020160*y5^2*y6^2, -3496805891386799763644306490059906677393394642091527615889434341076531727218710531389359487335589376890956033445887930837062815544433973855918267740953582783124373917824830990098011311051669865355865489408000000000000000000000000*y2^4*y6 + 19732572857738605756517083479642285183098860792532015813201649081880944674445558361376080634758743152562609357982992222895066757010164321028758023292133293467404852008268763434655747348583444281837876150272000000000000000000000000*y2^3*y3*y6 + 17926579268648467704161759202535434758279461613340443744639428755255625997705550814098958559847219317802204457749358161037688922826184165279490256917246873637220571927341642254554724921539130176940585538027520000000000000000000000*y2^3*y4*y6 + 23829797643167828689554606894145437572510447058466017284328850591840558086813940791802789129486943742886360017905370500372606703749047864496286037447634681626729157024856640986681043017410037631971208942583808000000000000000000000*y2^3*y5*y6 + 3496805891386799763644306490059906677393394642091527615889434341076531727218710531389359487335589376890956033445887930837062815544433973855918267740953582783124373917824830990098011311051669865355865489408000000000000000000000000*y2^3*y6^2 - 38759691965402735750693498210447609293028700977185351465762932721937360182489953404737625675646299074338327444185733467898565060831353932936712005395614067232112946303868819690506206054713735622379451166228480000000000000000000000*y2^2*y3^2*y6 - 60341311684805911310189254763169155616766490842211709748552873770547503175062587316860838890299006448306245098323991185773914422769627584553504210932349879502124688522195445659592468825134106754836878122287104000000000000000000000*y2^2*y3*y4*y6 - 91748567205019256869861474426935410289835717982843288407582067038274248801551731551147567746640776103938890332602588244189017660725548371455312258328887853595903313193591416821068753593933111135591304536260608000000000000000000000*y2^2*y3*y5*y6 - 19732572857738605756517083479642285183098860792532015813201649081880944674445558361376080634758743152562609357982992222895066757010164321028758023292133293467404852008268763434655747348583444281837876150272000000000000000000000000*y2^2*y3*y6^2 - 19231579558477612197208044290909946917740307864578305057195413197338656942488988624930083070655698256345742940218170270698894684774552102185560174178521849857282110982659493196643412072268900627728853714862080000000000000000000000*y2^2*y4^2*y6 - 89749560014182012284923996998125542932160013052752202871822354925924562055119662640599029307196123944209245247255453725018933037673362657214418164520637134173776837561078209462362419003046603926737066144038912000000000000000000000*y2^2*y4*y5*y6 - 17926579268648467704161759202535434758279461613340443744639428755255625997705550814098958559847219317802204457749358161037688922826184165279490256917246873637220571927341642254554724921539130176940585538027520000000000000000000000*y2^2*y4*y6^2 - 33486878987473466786605069657021020377265574253852530680228538640654472853626489745307962510596056576622101130174812835093395667941632488688183271691297449196398543244130505041273730323929538580263883067359232000000000000000000000*y2^2*y5^2*y6 - 23829797643167828689554606894145437572510447058466017284328850591840558086813940791802789129486943742886360017905370500372606703749047864496286037447634681626729157024856640986681043017410037631971208942583808000000000000000000000*y2^2*y5*y6^2 + 35479444742066366926795707160174268383862581224422828243229093793093787241540924929586025755992195840807722361034726893881942487867292787840223800304277423922617821408226041292013054831253045113327534284472320000000000000000000000*y2*y3^3*y6 + 54477901718528453496793911176378804810881276269096091988453419735148006689724183493712862935591134044865238219650807145948002533657306605348432256811168425106227188840967667641490064782542848411151669611462656000000000000000000000*y2*y3^2*y4*y6 + 108555099973738417747349746775924858554060042512655635690075290518107444867043919784570123294367261492216492069538805133464806204076465905361463521045661327888875713356772489978522412389420067306530460540076032000000000000000000000*y2*y3^2*y5*y6 + 35262886074015935987049191720387702615635306335093823849873498380860828455271242873348266188310709697447371410739845537061502245286919959080793737654660484448988572386043988700408194743662065757023585676820480000000000000000000000*y2*y3^2*y6^2 + 25985167192806790927793771447717029678184668617893723382606890423893068795227948331632013968311823047565425518229039685727483024983467021913664611214593369577922280351111058216752582256547377774992829701947392000000000000000000000*y2*y3*y4^2*y6 + 197222866493946711333241569725576358159423732118537290251540270446817794389714208675113803440790306748273171897498399819326504131798330146257286702896115803156271304730245476537284966994592206632455876946952192000000000000000000000*y2*y3*y4*y5*y6 + 63138756397915351121104699955217080958681206555884931841264421243408728556837555741972326480167477949819009925080701530443564675205174763638238825125112745728624187656455310451670877873975442647121570513813504000000000000000000000*y2*y3*y4*y6^2 + 64549694032534827378389063513839915496873391503474753115095695775043932696870997080253487697606714644095511467060804229698767793341288218488551434467285002676528394703128811797011403385746614723723149319340032000000000000000000000*y2*y3*y5^2*y6 + 84754955422245657342572861446815596935048928698660233175803198356121185347114310488368848771969597350156978265710812382514892029636680423743475722846980688029654565357941754840872730971829771404879573557444608000000000000000000000*y2*y3*y5*y6^2 - 5268710826544248313076496307842591778490073587472943937051413897732936288094541755420792199392765743389683682993988656056463797400160665899494537384315132569323074401448934704147985053205360529457710807121920000000000000000000000*y2*y4^3*y6 + 66305280379224401819882563736480158039929338540249526169816481135715558390630752555233243943436149380720549703204856191884774948875338727005582646815436273256200128601945501732532105915783854506476790253355008000000000000000000000*y2*y4^2*y5*y6 + 19231579558477612197208044290909946917740307864578305057195413197338656942488988624930083070655698256345742940218170270698894684774552102185560174178521849857282110982659493196643412072268900627728853714862080000000000000000000000*y2*y4^2*y6^2 + 5940820012304376046768751025401608896027153801404542640193424031400305501799822551952784548309049867266651434295770809197228780904778507575695786127779461546952099474421080037003254304892662974334064211787776000000000000000000000*y2*y4*y5^2*y6 + 86952115301072572474008551806077617590245297339078980779110807453063336673344694215487541717327652442696480420498743380349282785237815478129683550327874267947277338426818344670284009954205268034452373752512512000000000000000000000*y2*y4*y5*y6^2 - 41362656146193499673979483155625590114007832096781441670322959801338376083591546050536852763045925615340518278146584086493516139196787258616344793621668723495989530832528209939740669383227020222859966154801152000000000000000000000*y2*y5^3*y6 + 43977296661633866077537989127200740409445758180127113527896841663884068035282621339476040972602824707294969230512476627604584114574934410255938074914158197545771664997604998011567764257084548176331479535583232000000000000000000000*y2*y5^2*y6^2 - 16619199128326600738876492890503226011363161668667204640912304933753900533131516004897647088363466617095216869322333489992792591258707696198806415251073691495801848417789229204562434213276337224930580601241600000000000000000000000*y3^4*y6 - 5651024536055336637467898792774960124945895981917936564833249463504319874844375789052222807353384178731561324897882567431871895399742040794697023195868154591505313398435618265714220193388543444880805435801600000000000000000000000*y3^3*y4*y6 - 57764392572353927495018678777874878601519406921145813341363359883274943613519938931634039392822039107993814244586013915503882135130201027794585337277108949242841381588052776920799796702966392271217302041526272000000000000000000000*y3^3*y5*y6 - 19943038953991920886651791468603871213635794002400645569094765920504680639757819205877176506036159940514260243186800187991351109510449235438567698301288429794962218101347075045474921055931604669916696721489920000000000000000000000*y3^3*y6^2 + 17791462484245417939393522638063328636474177047217832190576181677272420385126941752086668482131708849621029697781593815569116673425446891152740993009539252515178970906858068655565326577810370844589071336996864000000000000000000000*y3^2*y4^2*y6 - 141929395420313386423949336340849609410711782958440491450990047065290945528024685196752346779420752759453387450299871097554524504603482084059968493263616068359849178842307543976566107599022394831026887283703808000000000000000000000*y3^2*y4*y5*y6 - 55974058863113142152035897507219501143570033717556449614900321960116729427882538321359702750379922201079715523071566211296912344605465229702103416978219912337379847394778860364361869503364210319651485102637056000000000000000000000*y3^2*y4*y6^2 - 84354380223596581060747666026842319124982004813743903302391912110745442578308966889970860167710465896967387581528867927067359606189692863973329896325893835245993203831286356714957870351537674920016697570099200000000000000000000000*y3^2*y5^2*y6 - 65966822369150307677095088619198290638537360539312706487259167939115039594229848532476836554309033605402387761293244280189727029590485296645035070540640514767911095856077414313950523606269272605450882319908864000000000000000000000*y3^2*y5*y6^2 - 2107484330617699325230598523137036711396029434989177574820565559093174515237816702168316879757106297355873473197595462422585518960064266359797814953726053027729229760579573881659194021282144211783084322848768000000000000000000000*y3*y4^3*y6 - 121478776080875257992327039796603704020010376698041785882468927335067233396175608133940262371698200902448428442499624903537143496233102371080610833656587232136722012743809107144417091420033059226833861023367168000000000000000000000*y3*y4^2*y5*y6 - 34731541181506685469292288425649526800978806481219634192895338482375118829842452132688205636452655498781659430915105525218333658373319995967787588362865136034699739624464642436239544096096010131975913349316608000000000000000000000*y3*y4^2*y6^2 - 48145100240425669783862935240588626366371470004329853174006310814831283240258958842022225944266587394143373035091026981208892795313243490874686769886742969950073015339890150440943339067384802022924910011088896000000000000000000000*y3*y4*y5^2*y6 - 135600845993269515621645345364081607693723847367367396787456827756968077904016491480786105516861151405220308119664780454014911261263949571065736131663916206445652338474883531736991307330976109100015458004762624000000000000000000000*y3*y4*y5*y6^2 + 40623400405995685070144466322132322624241407268165503541673422651156730095755528320443945781129003437643456125262129921403369925020042613529064114777535890371652490740907466639699993393495176096597201653858304000000000000000000000*y3*y5^3*y6 - 60701871397313068308796151608212306520618143338936044476129430736268910946817464242662969598632463357690412958037133001955678268478175967616213051388219755579537391439792563771185309628049524897728551731593216000000000000000000000*y3*y5^2*y6^2 + 2107484330617699325230598523137036711396029434989177574820565559093174515237816702168316879757106297355873473197595462422585518960064266359797814953726053027729229760579573881659194021282144211783084322848768000000000000000000000*y4^3*y5*y6 + 5268710826544248313076496307842591778490073587472943937051413897732936288094541755420792199392765743389683682993988656056463797400160665899494537384315132569323074401448934704147985053205360529457710807121920000000000000000000000*y4^3*y6^2 + 103687313596629840052933517158540375383536199650823953691892745657794813011048666381853593889566492052827398744718031087968026822807655479927869840647047979621543041836951038488851764842222688382244789686370304000000000000000000000*y4^2*y5^2*y6 - 57558906390524507278384046758547660917135200676923615359528033077233508356016248754177052275295316929504315790518790352393924315485485752951459669667164506799422669328591917513045144076235222149493706605985792000000000000000000000*y4^2*y5*y6^2 + 195725520196794392845280170374213195902029148944688281189829607343626548643128019827826795531040724332328321810288780646195289195316467615729352286346227192901427507580633312683223666859795740298832602730594304000000000000000000000*y4*y5^3*y6 - 66066683368396883103122989056055663029038281104114078477829964496281299249339184918633642657449417054105037908708631109159911840491000458413575197192927571026418407175971832114425109247687398598274667662802944000000000000000000000*y4*y5^2*y6^2 + 118114571518281424224498371373088101113623166135391417742994154276617556629204893506058600867766968184412962570175085411160664407558558974437657534076540585612983943096220896200620107874285228319567378559008768000000000000000000000*y5^4*y6 - 20609849881690815506012002598298983947996885263122378845593755689018157541059163762855801325942589458172146656970574700415243938509149153374078141965406330849621693238382079997195446932942304747625047216095232000000000000000000000*y5^3*y6^2]
            @test computed == expected
        end
    end
end
