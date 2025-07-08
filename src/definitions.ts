export interface GetLocalIPPlugin {
  echo(options: { value: string }): Promise<{ value: string }>;
}
