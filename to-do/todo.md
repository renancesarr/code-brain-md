# To-Do Inicial — Provisionamento Azion

- [ ] Criar estrutura básica do projeto (src/, dist/, .mcp-state/)
- [ ] Inicializar `package.json` com scripts para build e start
- [ ] Adicionar dependências: typescript, tsx, prompt-sync, @modelcontextprotocol/sdk
- [ ] Configurar `tsconfig.json` para compilar com NodeNext
- [ ] Criar `env.example` com AZION_TOKEN, CONTEXT7_API, UPLOAD_CONCURRENCY
- [ ] Implementar função `required(env)` para validação de variáveis
- [ ] Implementar `azion.create_bucket` com salvamento em .mcp-state/
- [ ] Implementar `azion.upload_dir` com suporte a gzip, MIME, sha256, dry_run
- [ ] Implementar `azion.create_edge_application` com edge_cache=true
- [ ] Implementar `azion.create_edge_connector` e `azion.add_origin_rule`
- [ ] Implementar `azion.create_domain` e `azion.deploy_domain_to_app`
- [ ] Implementar `azion.create_firewall`, `azion.create_waf_ruleset`, `azion.apply_waf_ruleset`
- [ ] Implementar orquestrador `azion.provision_static_site` interativo por parâmetros