require_relative '../handle_csv_from_excel'
require 'pp'

TEST_CSV_PATH = 'spec/test_CSV_from_読んだ本.csv' # セルの中に改行文字も入っているExcelから作った

describe '初期化' do
  let(:handler){HandleCsvFromExcel.new(TEST_CSV_PATH)}
  specify 'should be a valid object' do
    expect(handler).not_to be nil
  end
  it 'csvプロパティでCSVデータを保持する' do
    handler.csv.tap do |csv|
      expect(csv).not_to be nil
      expect(csv).to be_an Array
    end
  end
  let(:csv){handler.csv}
  it 'データの中に改行が入っていても、きちんと一つのデータとしてくれている。' do
    expect(csv.size).to be 9
  end
  it 'ヘッダ行をうまく読み込めている' do
    date_in_header = csv.first.first
    expect(date_in_header).to eq '読了日'
  end
end