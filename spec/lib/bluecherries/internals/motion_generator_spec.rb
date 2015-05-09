require 'spec_helper'
require 'bluecherries/internals/motion'

module BlueCherries
  describe MotionGenerator do
    describe '#generate' do
      context 'no restrictions are provided' do
        it 'returns all possible motions' do
          q_key = double(char: 'q')
          a_key = double(char: 'a')
          z_key = double(char: 'z')
          key_rows = [
            [q_key],
            [a_key],
            [z_key],
          ]
          qa = Motion.new([q_key, a_key])
          qz = Motion.new([q_key, z_key])
          aq = Motion.new([a_key, q_key])
          az = Motion.new([a_key, z_key])
          zq = Motion.new([z_key, q_key])
          za = Motion.new([z_key, a_key])

          generated_motions = MotionGenerator.new(key_rows, 2, []).generate

          expect(generated_motions).to match_array([qa, qz, aq, az, zq, za])
        end
      end

      context 'restrictions are provided' do
        it 'returns all possible motions except forbidden ones' do
          q_key = double(:q)
          a_key = double(:a)
          z_key = double(:z)
          key_rows = [
            [q_key],
            [a_key],
            [z_key],
          ]
          qa = Motion.new([q_key, a_key])
          qz = Motion.new([q_key, z_key])
          aq = Motion.new([a_key, q_key])
          az = Motion.new([a_key, z_key])
          zq = Motion.new([z_key, q_key])
          za = Motion.new([z_key, a_key])
          forbidden_motions = [zq, za]

          generated_motions = MotionGenerator.new(key_rows, 2,
            forbidden_motions).generate

          expect(generated_motions).to include(qa, qz, aq, az)
          expect(generated_motions).not_to include(*forbidden_motions)
        end
      end
    end
  end
end
