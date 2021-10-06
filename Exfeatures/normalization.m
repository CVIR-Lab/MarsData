function normfea = normalization(feature)
normfea = (feature - min(feature))./(max(feature)-min(feature));
end