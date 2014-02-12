describe 'node_env_test', ->
  it 'sets node_env to "test"', ->
    expect(process.env.NODE_ENV).to.equal 'test'
