function [ I ] = I_black(T, wvc)
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here
    C1 = 3.741771790075259e-16;
    C2 = 0.014387741858429;

	I = 1.0 ./ pi .* C1 .* ((wvc.*100).^3) ./ (exp(C2.*wvc.*100./T)-1);
end

