require 'pry'

class InvalidCodonError < RuntimeError
end

class Translation
  CODON_TO_PROTEIN = {
    'AUG' => 'Methionine',
    'UUU' => 'Phenylalanine',    'UUC' => 'Phenylalanine',
    'UUA' => 'Leucine',          'UUG' => 'Leucine',
    'UCU' => 'Serine', 'UCC' => 'Serine', 'UCA' => 'Serine', 'UCG' => 'Serine',
    'UAU' => 'Tyrosine',         'UAC' => 'Tyrosine',
    'UGU' => 'Cysteine',         'UGC' => 'Cysteine',
    'UGG' => 'Tryptophan',
    'UAA' => 'STOP', 'UAG' => 'STOP', 'UGA' => 'STOP'
  }
  CODONS = CODON_TO_PROTEIN.keys

  def self.of_codon(codon)
    CODON_TO_PROTEIN[codon]
  end

  def self.of_rna(strand)
    codons = Translation.get_codons(strand)
    raise InvalidCodonError if Translation.invalid?(codons)
    proteins = codons.map { |codon| Translation.of_codon(codon) }
    proteins.size == 1 ? proteins.flatten : proteins
  end

  def self.get_codons(strand)
    codons = []
    idx = 0
    while idx < strand.size &&
          Translation.of_codon(strand.slice(idx, 3)) != 'STOP'
      codons << strand.slice(idx, 3)
      idx += 3
    end
    codons
  end

  def self.invalid?(codons)
    codons.none? { |codon| CODONS.include?(codon) }
  end
end
