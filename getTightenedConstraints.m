function [lbx, ubx, lbu, ubu] = getTightenedConstraints(lbx, ubx, lbu, ubu, Q, R, beta)
    %Q and R are process noise covariance and measurement noise covariances
    %Both process noise and measurement noise are assumed Gaussian
    %If not Gaussian, need to use Chebyshev Cantelli equation
    %x = [soc, v1, v2, tc, ts] u =[i]
    
    nx = length(lbx);
    nu = length(lbu);
    gammax = sqrt(Q) * (erfinv(2*beta-1) * ones(nx,1));
    gammau = sqrt(R) * (erfinv(2*beta-1) * ones(nu,1));

    lbx = lbx + gammax;
    ubx = ubx - gammax;

    lbu = lbu + gammau; 
    ubu = ubu - gammau;
end

